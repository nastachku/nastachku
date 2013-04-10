class Web::SocialNetworksController < Web::ApplicationController

  def facebook

    authorization = Authorization.find_by_provider_and_uid(auth_hash[:provider], auth_hash[:uid])

    if authorization

      if authorization.user.inactive?
        flash_notice
        redirect_to root_path
        return
      end

      sign_in authorization.user
      flash_success
    else
      user = User.find_by_email(auth_hash[:info][:email])
      
      if !user
        save_auth_hash_to_session
        redirect_to new_user_path
        return
      end
        
      user.authorizations << build_authorization(auth_hash)

      if !user.inactive? && user.save
        user.activate
        sign_in user
        flash_success
      else
        flash_error
      end

    end    
    redirect_to root_path
  end

  def twitter

    #Если юзер уже авторизован, то линкуем его аккаунт с соц сетью
    if signed_in?
      save_auth_hash_to_session
      redirect_to link_twitter_account_social_networks_path if twitter_provider?
    else
      flash_error
      redirect_to root_path
    end

  end

  def failure
    flash_error
    redirect_to root_path
  end

end