FactoryGirl.define do
  factory :afterparty_ticket do
    user_id nil
    order_id nil
    ticket_code_id nil
    price 10

    trait :with_ticket_code do
      user
      ticket_code
    end
  end
end
