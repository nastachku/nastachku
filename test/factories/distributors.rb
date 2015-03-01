FactoryGirl.define do
  factory :distributor do
    title { generate :string }
    address { generate :string }
    contacts { generate :string }

    trait :nastachku do
      title { configus.default_distributor }
    end
  end
end
