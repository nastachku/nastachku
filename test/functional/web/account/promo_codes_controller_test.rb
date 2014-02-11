require 'test_helper'

class Web::Account::PromoCodesControllerTest < ActionController::TestCase
  setup do
    @promo_code = create :user_promo_code
    @user = create :user
    sign_in @user
  end

  test "should put accept" do
    put :accept, id: @promo_code, code: @promo_code.code

    @promo_code.reload
    assert_equal true, @promo_code.user.paid_part?
    assert_redirected_to welcome_index_path
  end

  test "should not put accept" do
    put :accept, id: @promo_code, code: "999999"

    @promo_code.reload
    assert_redirected_to edit_account_path
  end
end
