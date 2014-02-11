FactoryGirl.define do
  factory :ticket_order do
    items_count
    ticket_type "full"
    user
  end
end
