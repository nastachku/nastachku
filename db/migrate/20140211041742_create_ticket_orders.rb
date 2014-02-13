class CreateTicketOrders < ActiveRecord::Migration
  def change
    add_column :orders, :ticket_type, :string
  end
end
