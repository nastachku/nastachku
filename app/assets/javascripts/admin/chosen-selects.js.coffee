#enable chosen js
$('.chosen-select').each ->
  $(@).select2
    allowClear: true
    placeholder: $(@).data('placeholder')