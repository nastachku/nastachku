class Ticket < ActiveRecord::Base
  attr_accessible :price, :ticket_code

  belongs_to :order
  belongs_to :user
  belongs_to :ticket_code # TODO: belongs_to :code, class_name: 'TicketCode'

  scope :with_user, -> { where.not(user: nil) }

  def cancel
    self.user = nil
    ticket_code.cancel if ticket_code.present?
    save
  end

  def category
    ticket_code.present? ? ticket_code.category : "participant"
  end
end
