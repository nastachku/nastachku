class DateTimePickerInput < SimpleForm::Inputs::Base
  def input
    template.content_tag(:div, class: 'input-append date datetimepicker') do
      value = I18n.l object.send(attribute_name) || Time.current, format: :admin_date_time_picker
      @builder.text_field(attribute_name, input_html_options.merge(value: value)) +
      template.content_tag(:span, class: 'add-on') do
        template.tag(:i, data: { :'time-icon' => 'icon-time', :'date-icon' => 'icon-calendar' })
      end
    end
  end
end