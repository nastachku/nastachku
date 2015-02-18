FactoryGirl.define do
  factory :ticket_code do
    skip_create

    category "participant"
    count 10
  end

end
