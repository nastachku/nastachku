# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lecture do
    title
    thesises
    presentation { fixture_file_upload Rails.root.to_s + "/test/fixtures/photos/test.png", "image/png" }
    association :user
    association :workshop
  end
end
