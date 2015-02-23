class ActivateTicket
  def self.call(user, ticket_code)
    ActiveRecord::Base.transaction do
      user.create_ticket! price: ticket_code.price
      ticket_code.activate!
    end
  end
end
