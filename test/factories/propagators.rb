FactoryGirl.define do
  factory :propagator do
    title { generate :string }
    address { generate :string }
    contacts { generate :string }
  end

end
