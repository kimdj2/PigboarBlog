# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
    topBtn = $('#page-top')
    aboutBtn = $('#aboutBtn')
    footer = $('#footer')
    mainNav = $('#main_nav')
    mainTitle = $('#main_title')
    headerImage = $('#header_image')
    navSearch = $('#nav-search')
    main_contents = $('.main_contents')[0]
    topBtn.hide()
    if document.body.scrollTop > main_contents.offsetTop or document.documentElement.scrollTop > main_contents.offsetTop
        mainNav.css({height:"50px"})
        mainTitle.css({"margin-top":"50px"})
        mainNav.css('cssText', 'background-color: #343a40 !important;');
        navSearch.show()
    else
        mainNav.css({height:"100px"})
        mainTitle.css({"margin-top":"100px"})
        mainNav.css('cssText', 'background-color: transparent !important;');
        navSearch.hide()
    if document.body.scrollTop > 50 or document.documentElement.scrollTop > 50
        headerImage.css({"top":"-250px"})
    else
        headerImage.css({"top":"20px"})
    #スクロールが500に達したらボタン表示
    $(window).scroll (e)->
      if $(this).scrollTop() > 50
        topBtn.fadeIn()
      else
        topBtn.fadeOut()

      bottomY = 15
      $window = $(e.currentTarget)
      height = $window.height()
      scrollTop = document.documentElement.scrollTop
      documentHeight = $(document).height()
      footerHeight = $('#footer').height()
      bottomHeight = footerHeight + height + scrollTop + bottomY - documentHeight
      if scrollTop >= documentHeight - height - footerHeight + bottomY
        $('#page-top').css bottom: bottomHeight - bottomY + 45
      else
        $('#page-top').css bottom: bottomY
      if document.body.scrollTop > main_contents.offsetTop - 70 or document.documentElement.scrollTop > main_contents.offsetTop - 70 
        mainNav.css('cssText', 'background-color: #343a40 !important;')
        mainNav.css({height:"50px"})
        mainTitle.css({"margin-top":"50px"})
        navSearch.show()
      else
        mainNav.css('cssText', 'background-color: transparent !important;')
        mainNav.css({height:"100px"})
        mainTitle.css({"margin-top":"100px"})
        navSearch.hide()
      if document.body.scrollTop > 50 or document.documentElement.scrollTop > 50
        headerImage.css({"top":"-250px"})
      else
        headerImage.css({"top":"20px"})
      return
    #スクロールしてトップ
    topBtn.click ->
      $('body,html').animate { scrollTop: 0 }, 300

    #スクロールしてトップ
    aboutBtn.click ->
      $('body,html').animate { scrollTop: $("#main_image_about").offset().top  }, 300  
    return


