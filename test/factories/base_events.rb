# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :base_event do
    title "MyString"
    thesises "MyText"
    presentation "MyString"
    speaker_id 1
  end
end
