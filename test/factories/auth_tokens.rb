FactoryGirl.define do
  factory :user_auth_token, class: "User::AuthToken" do
    authentication_token { generate :auth_token }
    expired_at Time.current + 1.day
    user
  end
end
