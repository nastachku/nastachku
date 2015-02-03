# -*- coding: utf-8 -*-
class Web::SocialNetworksController < Web::ApplicationController
  def facebook
    user = FacebookAuthService.register(auth_hash)

    if user.inactive?
      flash_notice
      return redirect_to new_session_path
    end

    sign_in user
    save_auth_hash_to_session

    flash_success

    redirect_path = if configus.cs_cart.enable_auth
      auth_cs_cart_user_url get_auth_token authorization.user
    else
      :root
    end

    redirect_to redirect_path
  end

  def twitter
    # Если юзер уже авторизован, то линкуем его аккаунт с соц сетью
    if signed_in?
      save_auth_hash_to_session
      redirect_to link_twitter_account_social_networks_path if twitter_provider?
    else
      flash_error
      redirect_to new_session_path
    end
  end

  def failure
    flash_error
    redirect_to new_session_path
  end
end
