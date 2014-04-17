require 'test_helper'
require "#{Rails.root}/lib/custom_url_helper"

class CustomUrlHelperTest < ActiveSupport::TestCase
  include CustomUrlHelper
  test "link via social network cpath" do
    provider = generate :string
    assert_equal link_via_social_network_cpath(provider), "/auth/#{provider}"
  end

  test "twitter_account_curl" do
    name = generate :string
    assert_equal twitter_account_curl(name), "http://twitter.com/#{name}"
  end
end
