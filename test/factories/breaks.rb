# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :break, class: Event::Break do
    title
    association :workshop
  end
end
