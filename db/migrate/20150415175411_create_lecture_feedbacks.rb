class CreateLectureFeedbacks < ActiveRecord::Migration
  def change
    create_table :lecture_feedbacks do |t|
      t.references :user, index: true
      t.references :lecture, index: true
      t.integer :vote

      t.timestamps null: false
    end
    add_foreign_key :lecture_feedbacks, :users
    add_foreign_key :lecture_feedbacks, :lectures
  end
end
