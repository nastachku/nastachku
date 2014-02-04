# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_promo_code, :class => 'User::PromoCode' do
    code 1
    user_id 1
    accepted false
  end
end
