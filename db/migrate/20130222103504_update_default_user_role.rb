class UpdateDefaultUserRole < ActiveRecord::Migration
  def up
    User.reset_column_information
    User.update_all({:role => :user}, :role => nil)
  end

  def down
    User.update_all(:role => nil)
  end
end
