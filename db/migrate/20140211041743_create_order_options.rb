class CreateOrderOptions < ActiveRecord::Migration
  def change
    create_table :order_options do |t|
      t.integer :cost

      t.timestamps
    end
  end
end
