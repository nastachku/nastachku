class UpdateDefaultUserHideFromLectorsField < ActiveRecord::Migration
  def up
    User.reset_column_information
    User.update_all({:invisible_lector => :false}, :invisible_lector => nil)
  end

  def down
    User.update_all(:invisible_lector => nil)
  end
end
