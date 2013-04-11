class ApplicationController < ActionController::Base
  include AuthHelper
  include Mobylette::RespondToMobileRequests

  before_filter :deny_banned_user!

end

