window.onload = ->
  delay = (ms, func) -> setTimeout func, ms
  delay 4000, -> $('.alert').fadeOut('slow')

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
$(document).ready ->

  # Automagically jump on good tab based on anchor; for page reloads or links
  $("a[href=" + location.hash + "]").tab "show"  if location.hash

  # Update hash based on tab, basically restores browser default behavior to fix bootstrap tabs
  $(document.body).on "click", "a[data-toggle]", (event) ->
    location.hash = @getAttribute("href")

# on history back activate the tab of the location hash if exists or the default tab if no hash exists
$(window).on "popstate", ->
  anchor = location.hash or $("a[data-toggle=tab]").first().attr("href")
  $("a[href=" + anchor + "]").tab "show"



# popover demo
$(document).ready ->
  $("[data-toggle=popover]").popover()
