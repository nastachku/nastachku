class CreateDiscounts < ActiveRecord::Migration
  def change
    create_table :discounts do |t|
      t.string :code
      t.datetime :begin_date
      t.datetime :end_date
      t.integer :percent

      t.timestamps
    end
  end
end
