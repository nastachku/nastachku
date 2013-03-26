window.onload = ->
  delay = (ms, func) -> setTimeout func, ms
  delay 4000, -> $('.alert').fadeOut('slow')

  # side bar
  affixTop = $("#nav_top").outerHeight() + $("#nav_main").outerHeight() + $("header").outerHeight() + $(".content h1:first").outerHeight() + parseInt($(".content h1:first").css('marginTop')) + parseInt($(".content h1:first").css('marginBottom'))
  if ($(".content > h5:first").size() > 0)
    affixTop += $(".content > h5:first").outerHeight() + parseInt($(".content > h5:first").css('marginTop')) + parseInt($(".content > h5:first").css('marginBottom'))
  affixBottom = $(".sponsors").outerHeight() + parseInt($("#main_container").css("padding-bottom"))+ parseInt($(".border").css('marginTop'))
  affixHeight = $(".b-affix:first").outerHeight() + parseInt($(".b-affix:first li").css('marginBottom'))
  docHeight = $(document).height()
  bottomLimit = docHeight - affixBottom - affixHeight
  workshopHeight = $(".workshop").outerHeight()

  if (workshopHeight > affixHeight)
    setInterval (->
      b_affix()
    ), 1

  b_affix = ->
    curPos = $(window).scrollTop()
    if curPos > affixTop and curPos < bottomLimit
      $(".b-affix").addClass("top")
    else
      $(".b-affix").removeClass("top")

    if curPos > bottomLimit
      $(".b-affix").addClass("bottom")
    else
      $(".b-affix").removeClass("bottom")

$(document).ready ->

  # timetable long events hover
  $('.event').mouseenter ->
    heightSummary = $(this).find('.summary').outerHeight() + parseInt($(this).css('padding'))
    heightEvent = $(this).outerHeight()
    if heightSummary > heightEvent
      $(this).addClass('expand')
  .mouseleave ->
    $(this).removeClass('expand')

  # events editing table
  $('table').delegate 'a.edit-event', 'click', ->
    parent_row = $(this).closest('tr')
    parent_row.next().toggleClass('hidden')

  $('#my_events a.edit-event').click()

  $('table').delegate 'form.edit-event[data-remote]', 'ajax:success', (evt, data, status, xhr) ->
    row = $(this).closest('tr')
    row.after(data)
    row.prev().remove()
    row.remove()
    delay 4000, -> $('.alert').fadeOut('slow')

  # Twitter Bootstrap tabs hashes

  # Automagically jump on good tab based on anchor; for page reloads or links
  $("a[href=" + location.hash + "]").tab "show"  if location.hash

  # Update hash based on tab, basically restores browser default behavior to fix bootstrap tabs
  $(document.body).on "click", "a[data-toggle=tab]", (event) ->
    location.hash = @getAttribute("href")

# on history back activate the tab of the location hash if exists or the default tab if no hash exists
$(window).on "popstate", ->
  anchor = location.hash or $("a[data-toggle=tab]").first().attr("href")
  $("a[href=" + anchor + "]").tab "show"