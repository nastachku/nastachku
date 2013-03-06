# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_event, class: UserEvent do
    title "event title"
    thesises "event thesises"
    start_time
    finish_time
    presentation { fixture_file_upload Rails.root.to_s + "/test/fixtures/photos/test.png", "image/png" }
    association :speaker, factory: :user
    association :workshop
    association :hall
  end
end
