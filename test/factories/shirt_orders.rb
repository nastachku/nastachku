FactoryGirl.define do
  factory :shirt_order do
    user_id 1
    items_count
    item_size "L"
    item_color "white"
  end
end
