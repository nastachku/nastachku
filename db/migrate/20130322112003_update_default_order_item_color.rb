class UpdateDefaultOrderItemColor < ActiveRecord::Migration
  def up
    Order.reset_column_information
    Order.where(item_color: nil).update_all(item_color: :white)
  end

  def down
    Order.update_all(:item_color => :white)
  end
end
