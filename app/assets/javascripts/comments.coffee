# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# コメント作成キャンセルボタンイベント
$(document).on "click", '.cancel-comment-link', (e) ->
  # 重複イベント防止
  e.preventDefault()
  replied = $(this).data('reply')
  # console.log replied
  $comment = $(this).closest('.comment')
  # console.log $comment
  $form = $(this).closest('form')
  $restore_link = $comment.find('a.delete-comment-link')[0]
  #console.log $restore_link
  if replied is true
    $reply_link = $comment.find('a.reply-comment-link')[0]
    #console.log $reply_link
    if $reply_link
      $reply_link.href = "#{$restore_link.href}/reply"
  $edit_link = $comment.find('a.edit-comment-link')[0]
  #console.log $edit_link
  $edit_link.href = "#{$restore_link.href}/edit"
  # フォームを削除
  $form.remove()
