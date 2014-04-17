FactoryGirl.define do
  factory :ticket_order do
    items_count
    association :user
  end
end
