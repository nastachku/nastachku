require 'test_helper'

class Web::Account::SocialNetworksControllerTest < ActionController::TestCase
  setup do
    @auth_hash = generate(:twitter_auth_hash)
    @user = create :user
    @user.activate
    sign_in @user
  end

  test "should get unlink twitter account" do
    @user.twitter_name = @auth_hash[:info][:nickname]
    @user.save

    get :unlink_twitter

    assert_response :redirect
    assert current_user.twitter_name.empty?
  end

  test "should get link twitter account" do
    @user.twitter_name = ""
    @user.save
    request.env['omniauth.auth'] = @auth_hash
    save_twitter_name_to_session

    get :link_twitter

    assert_response :redirect
    assert !current_user.twitter_name.empty?
  end

end
