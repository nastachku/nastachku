class AddPersonalDataToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string  :name
      t.string  :surname
      t.string  :city
      t.string  :company
      t.boolean :show_as_participant
    end
  end
end
