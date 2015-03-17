class ChangeCampaignsDiscountPercentageToDiscountPrice < ActiveRecord::Migration
  def change
    rename_column :campaigns, :discount_percentage, :discount_amount
  end
end
