window.onload = ->
  delay = (ms, func) -> setTimeout func, ms
  delay 4000, -> $('.alert').fadeOut('slow')

  $('.edit-event').click ->
    parent_row = $(this).closest('tr')
    parent_row.next().toggleClass('hidden')

  $('form.edit-event[data-remote]').bind 'ajax:success', (evt, data, status, xhr) ->
    if data.errors.count > 0
      alert('Есть ошибки!')
    else
      alert('Ошибок нет!')
#    $this = $(this)
#    parent = $this.parent()
#    count = parent.find('.votings-count')
#    success_block = $('<div class="btn btn-no-clickable" />').html(parent.data('success'))
#
#    parent.find('a').remove()
#    parent.prepend(success_block)
#    count.html(parseInt(count.html()) + 1)


  