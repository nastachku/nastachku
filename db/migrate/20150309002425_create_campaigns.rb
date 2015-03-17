class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :name
      t.integer :tickets_count
      t.integer :afterparty_tickets_count
      t.datetime :start_date
      t.datetime :end_date
      t.integer :discount_percentage, default: 0, null: false
      t.references :order

      t.timestamps null: false
    end
  end
end
