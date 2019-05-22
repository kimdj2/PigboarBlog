$(document).on 'turbolinks:load', ->
    $loading = $('.ajax_loading')
    # Ajax ローディング
    $(document).ajaxError (xhr, status, error) ->
        console.log e
        console.log xhr
        console.log status
        $loading.hide()
        return
    $(document).on 'ajax:before', () -> 
        $loading.show()
    .on 'ajax:success', (e, xhr, status, error) ->
        console.log e
        console.log xhr
        console.log status
        $loading.hide()
    .on "ajax:error", (e, xhr, status, error) ->
        detail = e.detail;
        console.log e
        console.log detail[0]
        console.log detail[1]
        console.log detail[2].getResponseHeader('Test')
        $loading.hide()
    .on 'complete', (e, xhr, status, error) ->
        console.log event
        console.log xhr
        console.log status
        $loading.hide()