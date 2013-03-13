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