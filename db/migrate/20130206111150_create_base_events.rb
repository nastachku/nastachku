class CreateBaseEvents < ActiveRecord::Migration
  def change
    create_table :base_events do |t|
      t.string :title
      t.text :thesises
      t.string :presentation
      t.integer :speaker_id
      t.string :type
      t.string :state

      t.timestamps
    end
  end
end
