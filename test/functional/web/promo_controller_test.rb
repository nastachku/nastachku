require 'test_helper'

class Web::PromoControllerTest < ActionController::TestCase
  setup do
    @page = create :page, layout: :promo
  end

  test "should get show" do
    get :show, id: @page.slug

    assert_response :success
  end
end
