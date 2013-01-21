module AuthHelper
  # User auth
  def sign_in(user)
    session[:user_id] = user.id
  end

  def sign_out
    session[:user_id] = nil
  end

  def signed_in?
    session[:user_id] && User.find_by_id(session[:user_id])
  end

  def signed_as_admin?
    signed_in? && current_user.is_admin
  end

  def authenticate_user!
    redirect_to new_account_session_path unless signed_in?
  end

  def authenticate_admin!
    redirect_to new_account_session_path unless signed_as_admin?
  end

  def current_user
    @current_user ||= signed_in?
  end
end
