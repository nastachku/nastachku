FactoryGirl.define do
  #TODO  first_name, first_name, city to russian sequence
  factory :user do
    first_name { generate :string }
    middle_name { generate :string }
    last_name { generate :string }
    phone { generate :string }
    shirt_size { "L" }
    email
    password "ashQDR123!@#"

    city { generate :string }
    company
    position { generate :string }
    about
    show_as_participant
    twitter_name { generate :string }
    in_carousel true
    invisible_lector false
    carousel_info { generate :string }
    admin false
    role User.role.values.sample
    reason_to_give_ticket { generate :string }

    after(:create) do |user|
      user.activate
      FactoryGirl.create_list(:lecture, 5, user: user)
    end

  end

  factory :admin, parent: :user do
    admin true
  end

  factory :registrator, parent: :user do
    role :registrator
  end
end
