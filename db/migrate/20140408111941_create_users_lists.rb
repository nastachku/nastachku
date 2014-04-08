class CreateUsersLists < ActiveRecord::Migration
  def change
    create_table :users_lists do |t|
      t.text :file
      t.string :state

      t.timestamps
    end
  end
end
