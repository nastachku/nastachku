module AuthHelper

  def sign_in(user)
    session[:user_id] = user.id
    track_user user
  end

  def sign_out
    session[:user_id] = nil
  end

  def signed_in?
    current_user
  end

  def signed_as_admin?
    signed_in? && current_user.admin?
  end

  def authenticate_user!
    unless signed_in?
      redirect_to new_session_path(from: request.url)
    end
  end

  def authenticate_admin!
    redirect_to new_session_path unless signed_as_admin?
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |user, password|
      user == configus.basic_auth.username && password == configus.basic_auth.password
    end
  end

  def track_user(user)
    old_sign_in_at = user.current_sign_in_at 
    new_sign_in_at = Time.zone.now.utc

    user.last_sign_in_at = old_sign_in_at || new_sign_in_at
    user.current_sign_in_at = new_sign_in_at

    old_sign_in_ip = user.current_sign_in_ip
    new_sign_in_ip = request.remote_ip
    
    user.last_sign_in_ip = old_sign_in_ip || new_sign_in_ip
    user.current_sign_in_ip = new_sign_in_ip

    user.sign_in_count ||= 0
    user.sign_in_count += 1

    # user.changed_by = current_user

    #FIXME Скипаем валиадцию, так как в бд присутствуют невалидные пользователи 
    #(юзеры успели зарегаться до ввода некоторых валидаций)
    user.save(validate: false)
  end

end
