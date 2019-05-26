# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(window).on 'load', ->
  
  
$(document).on 'turbolinks:load', ->
  'use strict'
  window.DISQUSWIDGETS = undefined;
  $('.sidebar-dropdown > a').click ->
    $('.sidebar-submenu').slideUp 200
    if $(this).parent().hasClass('active')
      $('.sidebar-dropdown').removeClass 'active'
      $(this).parent().removeClass 'active'
    else
      $('.sidebar-dropdown').removeClass 'active'
      $(this).next('.sidebar-submenu').slideDown 200
      $(this).parent().addClass 'active'
    return
  $('#show-sidebar2').click ->
    $('.page-wrapper').addClass 'toggled'
    $('.page-content').addClass 'content-toggled'
    $('.page-content').addClass 'exec'
    return
  $('#close-sidebar').click ->
    $('.page-wrapper').removeClass 'toggled'
    $('.page-content').removeClass 'content-toggled'
    $('.page-content').removeClass 'exec'
    return
  $('.page-content').click ->
    if $('.page-content').hasClass('content-toggled')
      if !$('.page-content').hasClass('exec')
        $('.page-wrapper').removeClass 'toggled'
        $('.page-content').removeClass 'content-toggled'
      else
        $('.page-content').removeClass 'exec'
    return  
  $.getScript "//pigboars.disqus.com/count.js", -> 
    $('#masonry-container').masonry
      percentPosition: true
      itemSelector: '.mas-box'
      gutter: '.gutter-sizer'
      isResizable: true
    $('.mas-box').hide()
    $('.mas-box').each((i) ->
      $(this).delay(i * 100).fadeIn(1000))
    return
  $('pre code').each (i, block) ->
    hljs.highlightBlock block
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
  $('#mainNav').css({'background-color':'transparent'})
  if $(window).width() > MQL
    headerHeight = $('#mainNav').height()
    $(window).on 'scroll', { previousTop: 0 }, ->
      currentTop = $(window).scrollTop()
      #スクロールアップをキャッチする。
      if currentTop < 50
        $('#mainNav').css({'background-color':'transparent'})
      else
        $('#mainNav').css({'background-color':'#2E2E2E'})
      if currentTop < @previousTop
        #スクロールアップの場合、最上階以外はfixed領域に設定する。
        if currentTop > 0 and $('#mainNav').hasClass('fixed-top')
        # 最上階の場合は固定とする。
          $('#mainNav').slideDown()  
        else
          $('#mainNav').slideDown()
          $('#mainNav').addClass 'fixed-top'
      else if currentTop > @previousTop
        #スクロールダウンの場合
        # ナビゲーションを非表示とする。
        $('#mainNav').slideUp()
      @previousTop = currentTop
      return
    #スクロールしてトップ
    contactBtn.click ->
      $('body,html').stop().animate { scrollTop: $("#contact").offset().top }, 300  
    return





