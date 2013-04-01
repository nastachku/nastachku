class EventsInput < SimpleForm::Inputs::CollectionSelectInput
  def input
    type = object.send(:event_type)
    options.merge!(collection: type.constantize.scheduled, label_method: :full_title) if type.present?
    super
  end
end