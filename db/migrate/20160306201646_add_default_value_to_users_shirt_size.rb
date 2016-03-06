class AddDefaultValueToUsersShirtSize < ActiveRecord::Migration
  def up
    change_column :users, :shirt_size, :string, default: ""
  end

  def down
    # no way to reverse "default"
  end
end
