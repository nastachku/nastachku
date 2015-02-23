class AddCodeActivationProtectionFieldsToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.integer :code_activation_count, null: false, default: 0
      t.datetime :last_code_activation_at
    end
  end
end
