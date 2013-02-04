class UpdateUserTypeColumnWithDefaultValue < ActiveRecord::Migration
  def up
    User.reset_column_information
    User.update_all({type: "Member"}, :type => nil)
  end

  def down
    User.update_all(:type => nil)
  end
end
