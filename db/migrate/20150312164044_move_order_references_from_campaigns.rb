class MoveOrderReferencesFromCampaigns < ActiveRecord::Migration
  def change
    remove_column :campaigns, :order_id
    add_reference :orders, :campaign, index: true
    add_foreign_key :orders, :campaigns
  end
end
