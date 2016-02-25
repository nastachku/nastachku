class AddMoveToTopToLectures < ActiveRecord::Migration
  def change
    add_column :lectures, :move_to_top, :boolean
  end
end
