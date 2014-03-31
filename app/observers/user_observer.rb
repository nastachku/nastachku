class UserObserver < ActiveRecord::Observer
  include CsCartHelper
  observe :user
  def after_save(user)
    binding.pry
    redirect_to auth_user_url get_auth_token user
  end
end
