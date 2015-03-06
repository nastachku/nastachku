class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :partner
      t.integer :discount
      t.integer :commission
      t.string :code
      t.string :url
      t.string :state

      t.timestamps null: false
    end
  end
end
