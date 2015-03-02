FactoryGirl.define do
  factory :ticket do
    user_id nil
    order_id nil
    ticket_code_id nil
    price 10
  end

  factory :paper_ticket, parent: :ticket do
    user
    ticket_code
  end
end
