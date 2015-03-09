class Web::ApplicationController < ApplicationController
  include FlashHelper
  include SocNetworkHelper
  include Web::WorkshopsHelper
  include CustomUrlHelper
  include PlatidomaHelper
  include SecureHelper
  include CsCartHelper

  protect_from_forgery

  helper_method :title, :current_coupon

  before_filter do
    title t('base_name')
    title t("#{params[:controller].gsub('/', '.')}.#{params[:action]}.title")

    if params[:auth_token]
      token = User::AuthToken.find_by_authentication_token params[:auth_token]
      if token
        user = token.user
        @auth_email = user.email
      end
    end
    @auth_user = UserSignInType.new
  end

  private

  def title(part = nil)
    @parts ||= []
    unless part
      return nil if @parts.blank?
      return @parts.reverse.join(' | ')
    end
    @parts << part
  end

  def current_coupon
    @current_coupon ||= Coupon.active.find_by(code: session[:coupon_code]) if session[:coupon_code]
  end

end
