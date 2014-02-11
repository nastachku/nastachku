class ApplicationController < ActionController::Base
  include AuthHelper
  include Mobylette::RespondToMobileRequests

  helper_method :current_user, :signed_in?, :signed_as_admin?

  before_filter :deny_banned_user!

<<<<<<< HEAD
  # FIXME запхать это в конфигас как-нить
=======
>>>>>>> 940c36cc6eab2279d083dac39d5d976c4827fac5
  if Rails.env.production? or Rails.env.staging?
    rescue_from ActionController::RoutingError, ActionView::MissingTemplate, ActiveRecord::RecordNotFound do |exception|
      redirect_to "/404"
    end
  end
end
