# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
    #メールお問い合わせエラーハンドリング処理
    $('form#contactForm').on 'ajax:error', (event, xhr, status, error) ->
        #メッセージを表示する。
        alert 'メール送信に失敗しました。'
        # 入力欄をクリアする。
        $("#contact_name").val("")
        $("#contact_email").val("")
        $("#contact_message").val("")
        return
    return