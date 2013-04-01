class EventsInput < SimpleForm::Inputs::CollectionSelectInput
  def input
    type = object.send(:event_type)
    options.merge!(collection: type.constantize.scheduled) if type.present?
    super
  end
end