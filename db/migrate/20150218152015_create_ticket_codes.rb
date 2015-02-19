class CreateTicketCodes < ActiveRecord::Migration
  def change
    create_table :ticket_codes do |t|
      t.string :code
      t.references :distributor, index: true
      t.string :category
      t.string :state
      t.integer :price

      t.timestamps null: false
    end
    add_foreign_key :ticket_codes, :distributors
  end
end
