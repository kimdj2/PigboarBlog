#イメージアップロード処理
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
        toSummernote.summernote "insertImage", data.url

#summernote表示処理
$(document).on 'turbolinks:load', ->
    #スレッド作成時のテキストエディタ
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
            toolbar: [
                ['style', ['style']],
                ['font', ['bold', 'underline', 'clear']],
                ['fontname', ['fontname']],
                ['color', ['color']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['table', ['table']],
                ['insert', ['link', 'picture', 'video', 'map']],
                ['view', ['fullscreen', 'codeview','highlight', 'help']]
            ]
    #コメント作成時のテキストエディタ
    $('[data-provider="summernote2"]').each ->
        $(this).summernote
            lang: 'ja-JP'
            height: 200
            codemirror:
                lineWrapping: true
                lineNumbers: true
                tabSize: 2
                theme: 'solarized'
            toolbar: [
                ['font', ['bold', 'underline', 'clear']],
                ['fontname', ['fontname']],
                ['color', ['color']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['table', ['table']],
                ['insert', ['link']],
                ['view', ['help']],
                ['highlight', ['highlight']]
            ]            
    return