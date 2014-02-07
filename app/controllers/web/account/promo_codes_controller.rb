class Web::Account::PromoCodesController < Web::ApplicationController
  def accept
    @promo_code = User::PromoCode.find params[:id]
    if @promo_code.code == params[:code]
      @promo_code.user.pay_part
      flash_success
      redirect_to welcome_index_path
    else
      flash_error
      redirect_to edit_account_path
    end
  end
end
