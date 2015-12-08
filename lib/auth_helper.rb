# -*- coding: utf-8 -*-
module AuthHelper
  def sign_in(user)
    session[:user_id] = user.id
    mark_as_participant_on_first_login(user)
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

  def signed_as_registrator?
    signed_in? && (current_user.role.registrator? || current_user.admin?)
  end

  def authenticate_user!
    return if signed_in?
    redirect_to new_session_path(from: request.url)
  end

  def authenticate_admin!
    redirect_to new_session_path unless signed_as_admin?
  end

  def authenticate_registrator!
    redirect_to new_session_path(from: request.url) unless signed_as_registrator?
  end

  def current_user
    session ||= request.session
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def mark_as_participant_on_first_login(user)
    return if user.admin? || user.role == 'registrator'

    if user.last_sign_in_at.blank?
      user.update_attribute(:show_as_participant, true)
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

    user.save
  end

  def deny_banned_user!
    return unless signed_in? && current_user.inactive?

    sign_out
    redirect_to banned_path
  end

  def can_activate_code?
    current_user.code_activation_count < 10
  end

  def update_code_activation_count
    current_user.update(
      last_code_activation_at: Time.current,
      code_activation_count: current_user.code_activation_count += 1
    )
  end

  def clear_code_activation_count
    current_user.update(code_activation_count: 0)
  end

  def manage_code_activation_count
    if can_activate_code?
      update_code_activation_count
    elsif current_user.last_code_activation_at && current_user.last_code_activation_at < 10.minutes.ago
      clear_code_activation_count
    end
  end
end
