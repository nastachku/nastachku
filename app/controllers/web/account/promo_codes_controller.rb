# -*- coding: utf-8 -*-
class Web::Account::PromoCodesController < Web::Account::ApplicationController
  def accept
    @promo_code = User::PromoCode.find params[:id]
    if @promo_code.code == params[:code]
      @promo_code.user.pay_part
      flash_success
      redirect_to welcome_index_path
    else
      flash_error
      flash[:error] = flash[:error] #FIXME какого-то без этого не показывает flash
      redirect_to edit_account_path
    end
  end
end
