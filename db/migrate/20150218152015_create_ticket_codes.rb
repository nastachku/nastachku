class CreateTicketCodes < ActiveRecord::Migration
  def change
    create_table :ticket_codes do |t|
      t.string :code
      t.references :propagator, index: true
      t.string :category

      t.timestamps null: false
    end
    add_foreign_key :ticket_codes, :propagators
  end
end
