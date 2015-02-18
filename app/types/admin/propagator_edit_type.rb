class Admin::PropagatorEditType < Propagator
  include BasicType

  validates :title, presence: true
  validates :address, presence: true
  validates :contacts, presence: true

  permit :title, :address, :contacts
end
