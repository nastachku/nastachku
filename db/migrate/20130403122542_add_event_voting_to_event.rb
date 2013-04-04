class AddEventVotingToEvent < ActiveRecord::Migration
  def change
    add_column :events, :event_votings_count, :integer
  end
end