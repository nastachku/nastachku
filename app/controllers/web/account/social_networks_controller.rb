class Web::Account::SocialNetworksController < Web::ApplicationController

  def link_twitter
    current_user.twitter_name = session_twitter_name

    if current_user.save
      clear_session_auth_hash
      flash_success
    else
      flash_error
    end

    redirect_to edit_account_path
  end

  def unlink_twitter
    clear_twitter_link current_user

    if current_user.save
      flash_success
    else
      flash_error
    end

    redirect_to edit_account_path
  end

end
