$('a.vote-event[data-remote]').bind 'ajax:success', (evt, data, status, xhr) ->
  $this = $(this)
  parent = $this.parent()
  count = parent.find('.votings-count')
  success_block = $('<div class="btn btn-no-clickable" />').html(parent.data('success'))

  parent.find('a').remove()
  parent.prepend(success_block)
  count.html(parseInt(count.html()) + 1)

