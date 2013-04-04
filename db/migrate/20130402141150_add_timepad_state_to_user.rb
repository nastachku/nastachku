class AddTimepadStateToUser < ActiveRecord::Migration
  def change
    add_column :users, :timepad_state, :string
  end
end
