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

    after(:create) do |u|
      u.activate
    end
    
  end

  factory :admin, :parent => :user do
    admin true
  end

end