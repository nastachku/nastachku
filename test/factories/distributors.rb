FactoryGirl.define do
  factory :distributor do
    title { generate :string }
    address { generate :string }
    contacts { generate :string }
  end
end
