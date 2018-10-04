$(document).on 'turbolinks:load', ->
    $loading = $('.ajax_loading')
    # Ajax ローディング
    $(document).on 'ajax:before', () -> 
        $loading.show()
    .on 'ajax:error', () ->
        $loading.hide()
    .on 'ajax:success', () ->
        $loading.hide()
    .on 'complete', () ->
        $loading.hide()