# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :slot do
    association :event, factory: :user_event
    association :hall
    start_time "Wed, 11 Apr 2014 10:00:00 UTC +00:00"
    finish_time "Wed, 11 Apr 2014 11:30:00 UTC +00:00"
  end
end
