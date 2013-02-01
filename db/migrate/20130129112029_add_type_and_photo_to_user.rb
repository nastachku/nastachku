class AddTypeAndPhotoToUser < ActiveRecord::Migration
  def change
    add_column :users, :type, :string
    add_column :users, :photo, :string
  end
end
