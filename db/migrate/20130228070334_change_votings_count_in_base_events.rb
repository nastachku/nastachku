class ChangeVotingsCountInBaseEvents < ActiveRecord::Migration
  def change
    change_column :base_events, :votings_count, :integer, default: 0
  end
end
