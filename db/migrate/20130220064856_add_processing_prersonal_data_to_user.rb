class AddProcessingPrersonalDataToUser < ActiveRecord::Migration
  def change
    add_column :users, :process_personal_data, :boolean
  end
end
