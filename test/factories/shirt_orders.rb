# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :shirt_order do
    user
    count
    size "XXL"
  end
end
