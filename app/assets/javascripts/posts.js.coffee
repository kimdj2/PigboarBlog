sendFile = (file, toSummernote) ->
  data = new FormData
  data.append 'upload[file]', file
  $.ajax
    data: data
    type: 'POST'
    url: '/image_upload'
    cache: false
    contentType: false
    processData: false
    success: (data) ->
      console.log 'file uploading...'
      toSummernote.summernote "insertImage", data.url

$(document).on 'turbolinks:load', ->
    $('[data-provider="summernote"]').each ->
        $(this).summernote
            lang: 'ja-JP'
            height: 500
            codemirror:
                lineWrapping: true
                lineNumbers: true
                tabSize: 2
                theme: 'solarized'
            callbacks:
                onImageUpload: (files) ->
                    sendFile files[0], $(this)
    return