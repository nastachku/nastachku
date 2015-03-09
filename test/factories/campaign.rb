FactoryGirl.define do
  factory :campaign do
    name { generate :string }
    tickets_count 1
    afterparty_tickets_count 1
    start_date { Time.current - 1.day }
    end_date { Time.current + 1.day }
    discount_percentage 10
  end
end
