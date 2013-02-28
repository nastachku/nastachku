class CreateHalls < ActiveRecord::Migration
  def change
    create_table :halls do |t|
      t.string :title

      t.timestamps
    end
  end
end
