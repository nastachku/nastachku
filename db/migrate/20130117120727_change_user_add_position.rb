class ChangeUserAddPosition < ActiveRecord::Migration

  def change
    change_table :users do |t|
      t.string :position
    end
  end

end
