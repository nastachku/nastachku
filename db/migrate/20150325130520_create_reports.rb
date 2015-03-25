class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :data
      t.string :kind

      t.timestamps null: false
    end
  end
end
