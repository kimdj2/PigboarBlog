#エラーハンドラ
module ErrorHandler
    extend ActiveSupport::Concern
    included do
        # 他のエラーハンドリングでキャッチできなかった場合に
        # 500 Internal Server Error(システムエラー)を発生させる
        # NOTE: rescue_from は下から評価されるので記載箇所はここが正解
        rescue_from Exception, with: :handle_500

        # 例外に合わせたエラーハンドリング
        # 404 Not Found リソースが見つからない。アクセス権がない場合にも使用される
        rescue_from ActionController::RoutingError, with: :handle_404 
        rescue_from ActiveRecord::RecordNotFound,   with: :handle_404
        #rescue_from ActiveRecord::RecordNotUnique, with: :render_409
        #rescue_from IllegalAccessError,            with: :render_403

        # 認証エラーハンドリング
        # 401 no authorization 
        rescue_from ActionCable::Connection::Authorization::UnauthorizedError, with: :handle_401
    end

    # 500エラー制御
    def handle_500(e = nil)
        #ログ出力
        ErrorUtility.errorLogger(e)
        
        #ajax通信の場合
        if request.xhr?
            render json: { error: '500 error' }, status: 500
        #ajax通信以外の場合
        else
            #500ページをロードする。
            render file: "#{Rails.root}/public/500.html", layout: false, status: 500
        end
    end

    # 404エラー制御
    def handle_404(e = nil)
        #ログ出力
        ErrorUtility.errorLogger(e)
        
        #ajax通信の場合
        if request.xhr?
            render json: { error: '404 error' }, status: 404
        #ajax通信以外の場合
        else
            #404ページをロードする。
            render file: "#{Rails.root}/public/404.html", layout: false, status: 404
        end
    end

    # 401エラー制御
    def handle_401(e = nil)
        #ログ出力
        ErrorUtility.errorLogger(e)
        #ajax通信の場合
        if request.xhr?
            render json: { error: '401 error' }, status: 401
        #ajax通信以外の場合
        else
            #401ページをロードする。
            render "etc/user_error"
        end
    end
end