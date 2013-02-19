class AddPhotoAndStateToUser < ActiveRecord::Migration
  def change
    add_column :users, :photo, :string
    add_column :users, :state, :string
  end
end
