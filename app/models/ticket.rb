class Ticket < ActiveRecord::Base
  attr_accessible :price

  belongs_to :order
  belongs_to :user
  belongs_to :ticket_code
end
