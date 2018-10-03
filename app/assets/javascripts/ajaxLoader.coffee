$(document).on 'turbolinks:load', ->
    $loading = $('.ajax_loading')
    # Ajax ローディング
    $(document).on 'ajax:before', (event, xhr, status, error) -> 
        $loading.show()
    .on 'ajax:error', (event, xhr, status, error) ->
        $loading.hide()
    .on 'ajax:success', (event, xhr, status, error) ->
        $loading.hide()
