class AddVoteableToVotings < ActiveRecord::Migration
  def change
    add_column :votings, :voteable_id, :integer
    add_column :votings, :voteable_type, :string
  end
end
