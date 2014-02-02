window.onload = ->
  delay = (ms, func) -> setTimeout func, ms
  delay 10000, -> $('.alert').fadeOut('slow')
