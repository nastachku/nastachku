FactoryGirl.define do
  factory :user_promo_code, class: 'User::PromoCode' do
    code
    user
  end
end
