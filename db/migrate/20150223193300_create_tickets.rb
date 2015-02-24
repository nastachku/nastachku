class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.references :order, index: true
      t.references :user, index: true
      t.references :ticket_code, index: true
      t.float :price

      t.timestamps null: false
    end
    add_foreign_key :tickets, :orders
    add_foreign_key :tickets, :users
    add_foreign_key :tickets, :ticket_codes
  end
end
