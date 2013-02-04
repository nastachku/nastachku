class DeletePhotoAndTypeFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :photo
    remove_column :users, :type
  end
end
