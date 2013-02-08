# coding: utf-8

FactoryGirl.define do
  #TODO  first_name, first_name, city to russian sequence
  factory :user do
    password              "sekret"
    first_name "Строка"
    last_name "Строка"
    city "Строка"
    company
    show_as_participant
    email
    photo
#    process_personal_data

    after(:create) do |u|
      u.activate
    end
    
  end

  factory :admin, :parent => :user do
    admin true
  end
  
  factory :user_with_events, class: UserEventEditType do
    about "about info"
    photo { fixture_file_upload Rails.root.to_s + "/test/fixtures/photos/test.png", "image/png" }
    events_attributes  
  end

  
  factory :admin_with_events, parent: :user_with_events do
    admin true
  end
end