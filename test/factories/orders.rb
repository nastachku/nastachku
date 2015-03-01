# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
    user
    items_count

    trait :with_tickets do
      after(:create) do |instance|
        create_list :ticket, 1, order: instance
      end
    end
  end
end
