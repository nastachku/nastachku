class UpdateDefaultHallsState < ActiveRecord::Migration
  def up
    Hall.reset_column_information
    Hall.where(state: nil).update_all(state: :new)
  end

  def down
    Hall.update_all(:state => nil)
  end
end
