class AddDiscountAndPaymentSystem < ActiveRecord::Migration
  def change
    change_table :orders do |t|
      t.string  :payment_system
      t.integer  :discounts
    end
  end
end
