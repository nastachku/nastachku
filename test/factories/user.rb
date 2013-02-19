FactoryGirl.define do

  factory :user do
    password              "sekret"
    first_name
    last_name
    city
    company
    show_as_participant
    email
    photo

    after(:create) do |u|
      u.activate
    end
    
  end

  factory :admin, :parent => :user do
    admin true
  end

end