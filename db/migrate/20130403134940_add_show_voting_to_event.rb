class AddShowVotingToEvent < ActiveRecord::Migration
  def change
    add_column :events, :show_voting, :boolean
  end
end
