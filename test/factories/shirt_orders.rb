FactoryGirl.define do
  factory :shirt_order do
    user
    items_count
    item_size "L"
    item_color "white"
  end
end
