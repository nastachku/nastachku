$('.hall-form').bind 'cocoon:after-insert', ->
  $this = $ this
  $this.find('.datetimepicker').datetimepicker
    format: "yyyy-MM-dd hh:mm:ss"
  $this.find('.chosen-select').chosen
    allow_single_deselect: true
    no_results_text: 'Ничего не найдено по запросу'
