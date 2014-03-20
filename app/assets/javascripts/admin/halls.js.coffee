class Helpers
  @setSelectOptions: (selectElement, values, valueKey, textKey) ->
    selectElement.empty()
    if values.length > 0
      html = ("<option></option>")
      html += ("<option value='#{item[valueKey]}'>#{item[textKey]}</option>" for item in values)
      selectElement.append(html)

class TimeSlotEditWidget
  defaults:
    event_type_select_class: 'select.event-type-select'
    event_id_select_class: 'select.event-id-select'
  select2_options:
    placeholder: 'Выберите...'
    allowClear: true

  constructor: (options) ->
    @item = options.item
    @event_type_select_class = options.event_type_select_class || @defaults.event_type_select_class
    @event_id_select_class = options.event_id_select_class || @defaults.event_id_select_class
    @init()
    @bind()

  init: ->
    @event_id_dropdown = @item.find @event_id_select_class
    @event_type_dropdown = @item.find @event_type_select_class
    @event_type_dropdown.select2 @select2_options
    @event_id_dropdown.select2 @select2_options
    @item.find('.datetimepicker').datetimepicker format: "yyyy-MM-dd hh:mm:ss"
    @start_time_picker = @item.find('.start_time').closest('.datetimepicker')
    start_picker = @start_time_picker.data('datetimepicker')
    start_picker.setLocalDate(new Date(2014,3,11,9)) if start_picker
    @start_time_picker.on 'changeDate', (e) =>
      start_date = e.localDate
      console.log(start_date)
      finish_date = new Date(Date.parse(start_date))
      finish_date.setMinutes(finish_date.getMinutes() + 45)
      console.log(finish_date)
      picker = @item.find('.finish_time').closest('.datetimepicker').data('datetimepicker')
      picker.setLocalDate(new Date(finish_date))

  bind: ->
    @event_type_dropdown.on 'change', (e) =>
      val = e.val
      if val is ''
        @reload_select @event_id_dropdown, []
      else
        $.get Routes.api_events_path(type: val), (data) =>
          @reload_select @event_id_dropdown, data.root.events

  reload_select: (obj, data)->
    obj.select2("destroy")
    Helpers.setSelectOptions(obj, data, 'id', 'title')
    obj.select2 @select2_options



$('.hall-form .well').each -> new TimeSlotEditWidget item: $(@)
$('.hall-form').bind 'cocoon:after-insert', (e, inserted_item) -> new TimeSlotEditWidget item: $(inserted_item)
