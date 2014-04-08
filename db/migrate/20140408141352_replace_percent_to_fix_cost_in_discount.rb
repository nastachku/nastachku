class ReplacePercentToFixCostInDiscount < ActiveRecord::Migration
  def change
    remove_column :discounts, :percent
    add_column :discounts, :cost, :integer
  end
end
