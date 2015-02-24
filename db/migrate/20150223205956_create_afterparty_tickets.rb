class CreateAfterpartyTickets < ActiveRecord::Migration
  def change
    create_table :afterparty_tickets do |t|
      t.references :user, index: true
      t.references :order, index: true
      t.float :price

      t.timestamps null: false
    end
    add_foreign_key :afterparty_tickets, :users
    add_foreign_key :afterparty_tickets, :orders
  end
end
