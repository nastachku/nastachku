# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lecture do
    title
    thesises
    presentation
    association :user
    association :workshop
  end
end
