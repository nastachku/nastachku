FactoryGirl.define do
  factory :ticket_order do
    items_count
    type "full"
    user
  end
end
