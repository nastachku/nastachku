class ApplicationController < ActionController::Base
  include AuthHelper
  include Mobylette::RespondToMobileRequests
end

