class AddNotesToLecture < ActiveRecord::Migration
  def change
    add_column :lectures, :notes, :text
  end
end
