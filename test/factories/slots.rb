# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :slot do
    association :event
    association :hall
    start_time "Wed, 11 Apr 2015 10:00:00 UTC +00:00"
    finish_time "Wed, 11 Apr 2015 11:30:00 UTC +00:00"
  end
end
