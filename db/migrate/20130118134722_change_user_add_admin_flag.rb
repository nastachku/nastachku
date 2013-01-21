class ChangeUserAddAdminFlag < ActiveRecord::Migration

  def change
    change_table :users do |t|
      t.boolean :is_admin
    end
  end

end
