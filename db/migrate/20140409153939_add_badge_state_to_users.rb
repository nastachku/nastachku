class AddBadgeStateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :badge_state, :string
  end
end
