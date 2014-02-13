class CreateUserPromoCodes < ActiveRecord::Migration
  def change
    create_table :user_promo_codes do |t|
      t.string :code
      t.integer :user_id

      t.timestamps
    end
  end
end
