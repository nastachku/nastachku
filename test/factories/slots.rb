# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :slot do
    association :event, factory: :user_event
    association :hall
    start_time
    finish_time
  end
end
