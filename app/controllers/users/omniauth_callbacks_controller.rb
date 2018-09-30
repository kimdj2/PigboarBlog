class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    #facebook認証時
    def facebook
      callback_from :facebook
    end

    #twitter認証時
    def twitter
      callback_from :twitter
    end

    #github認証時
    def github
      callback_from :github
    end
  
    private
    def callback_from(provider)
      provider = provider.to_s

      #ユーザーテーブルよりユーザー情報を取得する。
      @user = User.find_for_oauth(request.env['omniauth.auth'])

      #テーブルに既に存在する場合
      if @user.persisted?
        #ログイン成功メッセージを作成する。
        flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
        #認証処理を行う。
        sign_in_and_redirect @user, event: :authentication
      #テーブルに存在しない場合
      else
        #セッションにユーザー情報を登録する。
        session["devise.#{provider}_data"] = request.env['omniauth.auth']
        #新しいユーザー情報をDBに登録する。
        redirect_to new_user_registration_url
      end
    end
  end