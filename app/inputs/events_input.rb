class EventsInput < SimpleForm::Inputs::CollectionSelectInput
  def input
    type = object.send(:event_type)
    options.merge!(collection: type.present? ? type.constantize.admin : [], label_method: :full_title)
    super
  end
end