# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  'use strict'
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
  # Show the navbar when the page is scrolled up
  MQL = 992
  #primary navigation slide-in effect
  if $(window).width() > MQL
    headerHeight = $('#mainNav').height()
    $(window).on 'scroll', { previousTop: 0 }, ->
      currentTop = $(window).scrollTop()
      #check if user is scrolling up
      if currentTop < @previousTop
        #if scrolling up...
        if currentTop > 0 and $('#mainNav').hasClass('is-fixed')
          $('#mainNav').addClass 'is-visible'
        else
          $('#mainNav').removeClass 'is-visible is-fixed'
      else if currentTop > @previousTop
        #if scrolling down...
        $('#mainNav').removeClass 'is-visible'
        if currentTop > headerHeight and !$('#mainNav').hasClass('is-fixed')
          $('#mainNav').addClass 'is-fixed'
      @previousTop = currentTop
      return
    #スクロールしてトップ
    contactBtn.click ->
      $('body,html').stop().animate { scrollTop: $("#contact").offset().top }, 300  
    return


