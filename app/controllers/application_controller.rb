# -*- coding: utf-8 -*-
class ApplicationController < ActionController::Base
  include AuthHelper
  include Mobylette::RespondToMobileRequests

  helper_method :current_user, :signed_in?, :signed_as_admin?

  before_filter :deny_banned_user!

  # FIXME запхать это в конфигас как-нить
  if Rails.env.production? or Rails.env.staging?
    rescue_from ActionController::RoutingError, ActionView::MissingTemplate, ActiveRecord::RecordNotFound do |e|
      logger.error "redirect to 404 => exception #{e.class.name} : #{e.message}"
      redirect_to "/404"
    end
  end

  private

  def expire_my_action(controller, action)
    expire_action controller: controller, action: action
    expire_action controller: controller, action: action, format: :js
  end

end
