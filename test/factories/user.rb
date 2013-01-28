FactoryGirl.define do

  factory :user, :class => UserEditType do
    password              "sekret"
    password_confirmation "sekret"
    name
    city
    company
    show_as_participant
    email

    after(:create) do |u|
      u.activate
    end
  end

  factory :admin, :parent => :user do
    admin true
  end

end