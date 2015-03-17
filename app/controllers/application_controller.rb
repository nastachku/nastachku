# -*- coding: utf-8 -*-
class ApplicationController < ActionController::Base
  include AuthHelper
  include Mobylette::RespondToMobileRequests

  helper_method :current_user, :signed_in?, :signed_as_admin?, :current_coupon

  before_filter :basic_auth_if_staging
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

  def basic_auth_if_staging
    if Rails.env.staging?
      authenticate_or_request_with_http_basic 'Staging' do |name, password|
        name == configus.basic_auth.username && password == configus.basic_auth.password
      end
    end
  end

  def current_coupon
    @current_coupon ||= Coupon.active.find_by(code: session[:coupon_code]) if session[:coupon_code]
  end

end
