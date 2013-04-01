class AddStateToHalls < ActiveRecord::Migration
  def change
    add_column :halls, :state, :string
  end
end
