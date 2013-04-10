setModalHeight = ->
  if Modernizr.mq('only screen and (max-width: 768px) and (orientation: landscape)')
    $('.modal-body').css({maxHeight: 150+"px"})
  if Modernizr.mq('only screen and (max-width: 768px) and (orientation: portrait)')
    $('.modal-body').css({maxHeight: 300+"px"})

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
    winWidth = $(window).width()
    if (winWidth > 760)
      curPos = $(window).scrollTop()
      if Modernizr.touch
        if curPos > affixTop and curPos < bottomLimit
          $(".b-affix").css({
            position: 'absolute',
            top: curPos - affixTop + "px",
            height: affixHeight + "px"
          })
        else
          $(".b-affix").css({
            position: 'static'
          })
        if curPos > bottomLimit
          $(".b-affix").css({
            position: 'absolute'
          })
          $(".b-affix").addClass("bottom")
        else
          $(".b-affix").removeClass("bottom")
      else
        if curPos > affixTop and curPos < bottomLimit
          $(".b-affix").addClass("top")
        else
          $(".b-affix").removeClass("top")

        if curPos > bottomLimit
          $(".b-affix").addClass("bottom")
        else
          $(".b-affix").removeClass("bottom")
    else
      $(".b-affix").removeClass("bottom")
      $(".b-affix").removeClass("top")

$(document).ready ->

  # timetable long events hover
  $('.event').mouseenter ->
    heightSummary = $(this).find('.summary').outerHeight() + parseInt($(this).css('paddingTop'))
    heightEvent = $(this).outerHeight()
    console.log heightSummary
    console.log heightEvent
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

  setModalHeight()
  $(window).resize ->
    setModalHeight()

# on history back activate the tab of the location hash if exists or the default tab if no hash exists
$(window).on "popstate", ->
  anchor = location.hash or $("a[data-toggle=tab]").first().attr("href")
  $("a[href=" + anchor + "]").tab "show"