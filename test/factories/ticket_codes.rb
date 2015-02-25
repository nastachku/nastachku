FactoryGirl.define do
  factory :ticket_code do
    category "participant"
    price 300
    code "7001f2f4g1"
    distributor
  end
end
