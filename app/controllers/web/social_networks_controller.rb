# -*- coding: utf-8 -*-
class Web::SocialNetworksController < Web::ApplicationController
  def auth
    social_network_service_name = params[:provider].titleize + "AuthService"
    user = social_network_service_name.constantize.register(auth_hash)

    if user.inactive?
      flash_notice
      return redirect_to new_session_path
    end

    sign_in user
    save_auth_hash_to_session

    flash_success

    redirect_path = if configus.cs_cart.enable_auth
      auth_cs_cart_user_url get_auth_token user
    else
      :root
    end

    redirect_to redirect_path
  end

  def failure
    flash_error
    redirect_to new_session_path
  end
end
