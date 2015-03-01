class AddTypeToTicketCodes < ActiveRecord::Migration
  def change
    add_column :ticket_codes, :kind, :string, default: "ticket"
  end
end
