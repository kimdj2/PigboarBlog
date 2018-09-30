$(document).on 'turbolinks:load', ->
    $('form#sign_in_user').on 'ajax:error', (event, xhr, status, error) ->
        $('#login_error_message').html("eメールもしくはパスワードが間違っています。")
        $('#user_password').val("")
        return
    $('form#sign_in_user').on 'ajax:before', (event, xhr, status, error) ->
        $('#login_error_message').html("")
        return
    return