class UpdateDefaultUserHideFromLectorsField < ActiveRecord::Migration
  def up
    User.reset_column_information
    User.where(invisible_lector: nil).update_all(invisible_lector: :false)
  end

  def down
    User.update_all(:invisible_lector => nil)
  end
end
