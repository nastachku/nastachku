FactoryGirl.define do
  factory :user_promo_code, class: 'User::PromoCode' do
    code
    ignore do
      user_id 1
    end
    after(:create) do |promo_code, evaluator|
      promo_code.user_id = evaluator.user_id
      promo_code.save!
    end
  end
end
