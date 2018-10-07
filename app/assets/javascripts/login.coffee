$(document).on 'turbolinks:load', ->
    #ログインフォームエラーハンドリング処理
    $('form#sign_in_user').on 'ajax:error', (event, xhr, status, error) ->
        #画面にメッセージを表示する。
        $('#login_error_message').html("eメールもしくはパスワードが間違っています。")
        #パスワードフォームをクリアする。
        $('#user_password').val("")
        return
    #ログインフォームajax通信直前のイベントハンドリング処理
    $('form#sign_in_user').on 'ajax:before', (event, xhr, status, error) ->
        #表示したエラーメッセージをクリアする。
        $('#login_error_message').html("")
        return
    return