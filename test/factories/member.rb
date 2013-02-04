FactoryGirl.define do

  factory :member do
    password              "sekret"
    name
    city
    company
    show_as_participant
    email
    photo

    after(:create) do |u|
      u.activate
    end
  end

end