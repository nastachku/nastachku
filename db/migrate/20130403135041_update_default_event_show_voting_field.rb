class UpdateDefaultEventShowVotingField < ActiveRecord::Migration
  def up
    Event.reset_column_information
    Event.update_all({show_voting: false}, show_voting: nil)
  end

  def down
    Event.update_all(show_voting: nil)
  end
end
