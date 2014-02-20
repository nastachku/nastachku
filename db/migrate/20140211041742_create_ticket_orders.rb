class CreateTicketOrders < ActiveRecord::Migration
  def change
    create_table :ticket_orders do |t|
      t.string :type

      t.timestamps
    end
  end
end
