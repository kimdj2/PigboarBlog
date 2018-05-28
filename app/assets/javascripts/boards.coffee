# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
 $ ->  
    setImagePath = ->
        boardContents = $.parseHTML($('#board_contents').val())[0]
        if boardContents
            contents = boardContents.getElementsByTagName('img')[0].src
        else
            contents = ''
        $('#board_image_path').val(contents)
        document.forms[0].commit
        return true
    return
