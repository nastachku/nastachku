class DateTimePickerInput < SimpleForm::Inputs::Base
  def input
    template.content_tag(:div, class: 'input-append date datetimepicker') do
      @builder.text_field(attribute_name, input_html_options) +
      template.content_tag(:span, class: 'add-on') do
        template.tag(:i, data: { :'time-icon' => 'icon-time', :'date-icon' => 'icon-calendar' })
      end
    end
  end
end