FactoryGirl.define do

  factory :user, :class => UserEditType do
    password              "sekret"
    password_confirmation "sekret"
    name
    city
    company
    show_as_participant
    email
  end

  factory :update_user, :parent => :user do
    email
    password "sicret"
    password_confirmation "sicret"
  end
end