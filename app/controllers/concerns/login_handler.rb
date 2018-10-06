module LoginHandler
    extend ActiveSupport::Concern
    included do
    end

    #ログインする時のリダイレクト処理
    def after_sign_in_path_for(resource)
        if (session[:previous_url] == root_path)
        super
        else
        session[:previous_url] || root_path
        end
    end
    
    #ログアウトする時のリダイレクト処理
    def after_sign_out_path_for(resource_or_scope)
        #ログアウトする前のページに遷移する。
        request.referrer
    end 
    
    #認証チェック処理
    def authenticate
        raise ActionCable::Connection::Authorization::UnauthorizedError unless user_signed_in?
    end

end