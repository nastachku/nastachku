class UpdateDefaultUserRole < ActiveRecord::Migration
  def up
    User.reset_column_information
    User.where(role: nil).update_all(role: :user)
  end

  def down
    User.update_all(role: nil)
  end
end
