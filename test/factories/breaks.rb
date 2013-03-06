# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :break, class: Event::Break do
    title
    start_time
    finish_time
    association :hall
    association :workshop
  end
end
