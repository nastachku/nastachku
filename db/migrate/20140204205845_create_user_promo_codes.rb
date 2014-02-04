class CreateUserPromoCodes < ActiveRecord::Migration
  def change
    create_table :user_promo_codes do |t|
      t.integer :code
      t.integer :user_id
      t.boolean :accepted

      t.timestamps
    end
  end
end
