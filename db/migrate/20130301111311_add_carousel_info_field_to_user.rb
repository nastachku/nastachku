class AddCarouselInfoFieldToUser < ActiveRecord::Migration
  def change
    add_column :users, :carousel_info, :text
  end
end
