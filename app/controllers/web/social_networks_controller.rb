# -*- coding: utf-8 -*-
class Web::SocialNetworksController < Web::ApplicationController

  def facebook
    authorization = Authorization.find_by_provider_and_uid(auth_hash[:provider], auth_hash[:uid])
    if authorization
      if authorization.user.inactive?
        flash_notice
        return redirect_to new_session_path
      end
      sign_in authorization.user
      flash_success
      return redirect_to edit_account_path
    else
      user = User.find_by_email(auth_hash[:info][:email])
      if !user
        save_auth_hash_to_session
        return redirect_to new_user_path
      end
      user.authorizations << build_authorization(auth_hash)
      # на стачке 2013 не было адреса фейсбука в аккаунте, а в 2014
      # появился, это для новых пользователй
      user.facebook = auth_hash[:info][:urls][:Facebook]
      if !user.inactive? && user.save
        user.activate
        sign_in user
        flash_success
        return redirect_to welcome_index_path
      else
        flash_error
        return redirect_to new_session_path
      end
    end    
  end

  def twitter
    #Если юзер уже авторизован, то линкуем его аккаунт с соц сетью
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
