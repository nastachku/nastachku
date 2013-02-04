class UpdateUserStateColumnWithDefaultValue < ActiveRecord::Migration
  def up
    User.reset_column_information
    User.update_all({:state => :active}, :state => nil)
  end

  def down
    Course.update_all(:state => nil)
  end
end
