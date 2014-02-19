FactoryGirl.define do
  factory :shirt_order do
    items_count
    item_size "L"
    item_color "white"
    association :user
  end
end
