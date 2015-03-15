class Distributor < ActiveRecord::Base
  attr_accessible :title, :address, :contacts

  scope :asc_by, ->(field) { order(field => :asc) }
  has_many :codes, class_name: :TicketCode

  def to_s
    title
  end
end
