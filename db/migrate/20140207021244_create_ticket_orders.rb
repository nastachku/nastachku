class CreateTicketOrders < ActiveRecord::Migration
  def change
    create_table :ticket_orders do |t|
      t.timestamps
    end
  end
end
