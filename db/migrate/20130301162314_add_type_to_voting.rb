class AddTypeToVoting < ActiveRecord::Migration
  def change
    add_column :votings, :type, :string
  end
end
