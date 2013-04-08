class AddChecboxNotGoingToUser < ActiveRecord::Migration
  def change
    add_column :users, :not_going_to_conference, :boolean
  end
end
