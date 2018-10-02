class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :setContact
  after_action  :store_location
  include BlogCommon

  def store_location
    if (request.fullpath != new_user_registration_path &&
        request.fullpath != new_user_session_path &&
        request.fullpath !~ Regexp.new("\\A/users/password.*\\z") &&
        !request.xhr?)
      session[:previous_url] = request.fullpath 
    end
  end
 
  def after_sign_in_path_for(resource)
    if (session[:previous_url] == root_path)
      super
    else
      session[:previous_url] || root_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    request.referrer
  end 
   
  protected

  def configure_permitted_parameters
    added_attrs = [:email, :username, :password, :password_confirmation]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def setTagAndCategory
    @tags = ActsAsTaggableOn::Tag.where("taggings_count <> 0").order(name: "ASC")
    @board_month = Board.select("date_trunc( 'month', created_at ) as month, count(*) as total_month").group('month')
  end 
  
  def setContact
    @contact = Contact.new
  end 
      # エラーハンドリング処理
      def handle_500(e = nil)
        #ログ出力
        ErrorUtility.errorLogger(e)

        if request.xhr?
        # Ajaxのための処理
        render json: { error: '500 error' }, status: 500
        else
        render template: 'errors/error_500', status: 500, layout: 'application', content_type: 'text/html'
        end
    end

    def handle_404(e = nil)
        #ログ出力
        ErrorUtility.errorLogger(e)
        
        #ajax通信の場合
        if request.xhr?
            render json: { error: '404 error' }, status: 404
        #ajax通信以外の場合
        else
            render file: "#{Rails.root}/public/404.html", layout: false, status: 500
        end
    end

end
