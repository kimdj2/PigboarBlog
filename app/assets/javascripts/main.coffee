# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
  $ ->  
    topBtn = $('#page-top')
    footer = $('#footer')
    mainNav = $('#main_nav')
    mainTitle = $('#main_title')
    headerImage = $('#header_image')
    topBtn.hide()
    if document.body.scrollTop > 20 or document.documentElement.scrollTop > 20
        mainNav.css({height:"50px"})
        mainTitle.css({"margin-top":"50px"})
        headerImage.css({"top":"-100px"})
    else
        mainNav.css({height:"100px"})
        mainTitle.css({"margin-top":"100px"})
        headerImage.css({"top":"0px"})
    #スクロールが500に達したらボタン表示
    $(window).scroll (e)->
      if $(this).scrollTop() > 50
        topBtn.fadeIn()
      else
        topBtn.fadeOut()

      bottomY = 30
      $window = $(e.currentTarget)
      height = $window.height()
      scrollTop = document.documentElement.scrollTop
      documentHeight = $(document).height()
      footerHeight = $('#footer').height()
      bottomHeight = footerHeight + height + scrollTop + bottomY - documentHeight
      if scrollTop >= documentHeight - height - footerHeight + bottomY
        $('#page-top').css bottom: bottomHeight - bottomY + 60
      else
        $('#page-top').css bottom: bottomY
      if document.body.scrollTop > 20 or document.documentElement.scrollTop > 20
        mainNav.css({height:"50px"})
        mainTitle.css({"margin-top":"50px"})
        headerImage.css({"top":"-100px"})
      else
        mainNav.css({height:"100px"})
        mainTitle.css({"margin-top":"100px"})
        headerImage.css({"top":"0px"})
      return
    #スクロールしてトップ
    topBtn.click ->
      $('body,html').animate { scrollTop: 0 }, 300
    return


