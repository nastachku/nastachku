# -*- coding: utf-8 -*-
class Web::SocialNetworksController < Web::ApplicationController
  def auth
    social_network_service_name = params[:provider].titleize + "AuthService"
    user = social_network_service_name.constantize.register(auth_hash, cookies)

    if user.inactive?
      flash_notice
      return redirect_to new_session_path
    end

    # FIXME странная концепция с промо-кодами. Выпилить это, когда приведутся в порядок промо-коды
    User::PromoCode.create({ code: generate_promo_code, user_id: user.id }) unless user.promo_code

    sign_in user

    flash_success

    redirect_path = if configus.cs_cart.enable_auth && auth_cs_cart_valid_user?(user)
      auth_cs_cart_user_url get_auth_token user
    else
      edit_account_path(anchor: :orders)
    end

    redirect_to redirect_path
  end

  def failure
    flash_error
    redirect_to new_session_path
  end
end
