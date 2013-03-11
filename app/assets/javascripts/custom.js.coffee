window.onload = ->
  delay = (ms, func) -> setTimeout func, ms
  delay 4000, -> $('.alert').fadeOut('slow')

  # side bar
  affixTop = $("#nav_top").outerHeight() + $("#nav_main").outerHeight() + $("header").outerHeight() + $(".content h1:first").outerHeight()
  affixBottom = $(".sponsors").outerHeight() + parseInt($("#main_container").css("padding-bottom"))

  $("#section_submenu").affix offset:
    top: affixTop
    bottom: affixBottom