window.onload = ->
  delay = (ms, func) -> setTimeout func, ms
  delay 4000, -> $('.alert').fadeOut('slow')

  # side bar
  affixTop = $("#nav_top").outerHeight() + $("#nav_main").outerHeight() + $("header").outerHeight() + $(".content h1:first").outerHeight()
  affixBottom = $(".sponsors").outerHeight() + parseInt($("#main_container").css("padding-bottom"))
  affixHeight = $(".b-affix:first").outerHeight()
  docHeight = $(document).height()

  setInterval (->
    b_affix()
  ), 1

  b_affix = ->
    curPos = $(window).scrollTop()
    if curPos > affixTop and curPos < docHeight - affixBottom - affixHeight
      $(".b-affix").addClass("top")
    else
      $(".b-affix").removeClass("top")

    if curPos > docHeight - affixBottom - affixHeight
      $(".b-affix").addClass("bottom")
    else
      $(".b-affix").removeClass("bottom")

    console.log affixBottom