class AddPayStateToUser < ActiveRecord::Migration
  def change
    add_column :users, :pay_state, :string
  end
end
