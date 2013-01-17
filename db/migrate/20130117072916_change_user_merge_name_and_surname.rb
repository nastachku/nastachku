class ChangeUserMergeNameAndSurname < ActiveRecord::Migration

  def change
    remove_column :users, :surname
  end

end
