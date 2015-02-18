class CreatePropagators < ActiveRecord::Migration
  def change
    create_table :propagators do |t|
      t.string :title
      t.string :address
      t.string :contacts

      t.timestamps null: false
    end
  end
end
