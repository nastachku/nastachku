class AddIndexEmailToUser < ActiveRecord::Migration
  def up
    add_index :users, :email, name: 'index_users_on_email'
  end

  def down
    remove_index :users, 'index_users_on_email'
  end
end
