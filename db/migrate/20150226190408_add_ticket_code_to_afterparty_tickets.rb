class AddTicketCodeToAfterpartyTickets < ActiveRecord::Migration
  def change
    add_reference :afterparty_tickets, :ticket_code, index: true
    add_foreign_key :afterparty_tickets, :ticket_codes
  end
end
