class EventsInput < SimpleForm::Inputs::CollectionSelectInput
  def input
    type = object.send(:event_type)
    options.merge!(collection: type.constantize.admin) if type.present?
    super
  end
end