class UpdateDefaultEventShowVotingField < ActiveRecord::Migration
  def up
    Event.reset_column_information
    Event.where(show_voting: nil).update_all(show_voting: false)
  end

  def down
    Event.update_all(show_voting: nil)
  end
end
