# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
    $('form#contactForm').on 'ajax:error', (event, xhr, status, error) ->
        alert 'メール送信に失敗しました。'
        $("#contact_name").val("")
        $("#contact_email").val("")
        $("#contact_message").val("")
        return
    return