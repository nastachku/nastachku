class StachkaCheckboxInput < SimpleForm::Inputs::BooleanInput
  def input(wrapper_options = nil)
    input_html_options[:class] << "checkbox_type-1"
    input_html_options[:label] = false

    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

    out = build_check_box(unchecked_value, merged_input_options)

    out << content_tag(:label, label_text)
  end
end
