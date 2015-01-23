Auditable::Audit.class_eval do
  attr_accessible :action, :modifications, :changed_by

end
