# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :shirt_order do
    user
    items_count
    item_size "L"
    item_color "white"
  end
end
