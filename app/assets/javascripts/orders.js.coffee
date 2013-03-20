$(".items-count-select").on 'change', ->
  cost = parseInt($(@).val()) * gon.price
  $('.cost').html cost