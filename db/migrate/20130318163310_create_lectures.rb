class CreateLectures < ActiveRecord::Migration
  def change
    create_table :lectures do |t|
      t.string :state
      t.string :presentation
      t.integer :listener_votings_count, default: 0
      t.integer :lecture_votings_count, default: 0
      t.integer :user_id
      t.string   :title
      t.text     :thesises
      t.integer  :workshop_id
      t.timestamps
    end
  end
end
