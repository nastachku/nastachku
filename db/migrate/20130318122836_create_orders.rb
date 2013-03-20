class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.string :type
      t.integer :count
      t.string :size
      t.string :payment_state
      t.string :transaction_id

      t.timestamps
    end
  end
end
