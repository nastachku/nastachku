class UpdateDefaultHallsState < ActiveRecord::Migration
  def up
    Hall.reset_column_information
    Hall.update_all({:state => :new}, :state => nil)
  end

  def down
    Hall.update_all(:state => nil)
  end
end
