class StateEventInput < SimpleForm::Inputs::CollectionSelectInput
  def collection
    object.send(transitions)
  end

  def input
    label_method = :human_event
    value_method = :event
    current_state = template.content_tag(:div, template.content_tag(:span, "Current state: #{object.send(human_name)}", :class => "label label-info")  )

    out = @builder.collection_select(
      attribute_name, collection, value_method, label_method,
      input_options, input_html_options
    )
    (out << current_state).html_safe
  end

  private
  def machine_name
    attribute_name.to_s.gsub "_event", ""
  end

  def transitions
    "#{machine_name}_transitions"
  end

  def human_name
    "human_#{machine_name}_name"
  end
end