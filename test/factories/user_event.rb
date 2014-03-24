FactoryGirl.define do
  factory :user_event, class: UserEvent do
    title "event title"
    thesises "event thesises"
    #start_time
    #finish_time
    #presentation { fixture_file_upload('app/assets/images/logo.png') }
    association :speaker, factory: :user
    association :workshop
    #association :hall
  end
end
