class AddCarouselCheckboxToUsers < ActiveRecord::Migration
  def change
    add_column :users, :in_carousel, :boolean
  end
end
