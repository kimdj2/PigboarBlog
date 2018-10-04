module BlogCommon
    extend ActiveSupport::Concern

    included do
        include ErrorHandler
        before_action :setContact
        before_action :setResentBoard
        before_action :set_header_image
        before_action :configure_permitted_parameters, if: :devise_controller?
        after_action  :store_location
    end

    #Tag,Archive情報設定
    def setTagAndCategory
        @tags = ActsAsTaggableOn::Tag.where("taggings_count <> 0").order(name: "ASC")
        @board_month = Board.select("date_trunc( 'month', created_at ) as month, count(*) as total_month").group('month')
    end 
    
    #ログイン時、前のページを記憶する。
    def store_location
        if (request.fullpath != new_user_registration_path &&
            request.fullpath != new_user_session_path &&
            request.fullpath !~ Regexp.new("\\A/users/password.*\\z") &&
            !request.xhr?)
            session[:previous_url] = request.fullpath 
        end
    end
    
    #privateメソッド     
    private

    #メールお問い合わせダミデータ生成
    def setContact
        @contact = Contact.new
    end 

    #最新のポスト内容を取得する。
    def setResentBoard
        @boards_resent = Board.all.order(created_at:"DESC").limit(5)
    end

    #deviseパラメータ設定
    def configure_permitted_parameters
        added_attrs = [:email, :username, :password, :password_confirmation]
        devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
        devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    end

    #ヘッダイメージ設定
    def set_header_image
        if controller_name == "main"
            @header_image = "home-bg.jpg"
        elsif controller_name == "etc"
            @header_image = "about-bg.jpg"
        else 
            @header_image = "post_header.jpg"
        end    
    end
end
