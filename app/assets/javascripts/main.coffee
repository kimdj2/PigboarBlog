# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  'use strict'
  $('pre code').each (i, block) ->
    hljs.highlightBlock block
  return
  contactBtn = $('#contact_btn')
  $('body').on('input propertychange', '.floating-label-form-group', (e) ->
    $(this).toggleClass 'floating-label-form-group-with-value', ! !$(e.target).val()
    return
  ).on('focus', '.floating-label-form-group', ->
    $(this).addClass 'floating-label-form-group-with-focus'
    return
  ).on 'blur', '.floating-label-form-group', ->
    $(this).removeClass 'floating-label-form-group-with-focus'
    return
  # スクロールアップ時のナビゲーション表示制御
  MQL = 992
  # PC環境の場合
  if $(window).width() > MQL
    headerHeight = $('#mainNav').height()
    $(window).on 'scroll', { previousTop: 0 }, ->
      currentTop = $(window).scrollTop()
      #スクロールアップをキャッチする。
      if currentTop < @previousTop
        #スクロールアップの場合、最上階以外はfixed領域に設定する。
        if currentTop > 0 and $('#mainNav').hasClass('is-fixed')
          $('#mainNav').addClass 'is-visible'
        # 最上階の場合は固定とする。
        else
          $('#mainNav').removeClass 'is-visible is-fixed'
      else if currentTop > @previousTop
        #スクロールダウンの場合
        # ナビゲーションを非表示とする。
        $('#mainNav').removeClass 'is-visible'
        if currentTop > headerHeight and !$('#mainNav').hasClass('is-fixed')
          $('#mainNav').addClass 'is-fixed'
      @previousTop = currentTop
      return
    #スクロールしてトップ
    contactBtn.click ->
      $('body,html').stop().animate { scrollTop: $("#contact").offset().top }, 300  
    return


