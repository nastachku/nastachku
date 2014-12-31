class UpdateUserStateColumnWithDefaultValue < ActiveRecord::Migration
  def up
    User.reset_column_information
    User.where(state: nil).update_all(state: :active)
  end

  def down
    Course.update_all(:state => nil)
  end
end
