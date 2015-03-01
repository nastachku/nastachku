FactoryGirl.define do
  factory :buy_now_order, class: 'BuyNowOrderType' do
    tickets 2
    afterparty_tickets 2
    name
    phone
    email
  end
end
