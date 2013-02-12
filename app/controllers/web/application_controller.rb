class Web::ApplicationController < ApplicationController  
  include AuthHelper
  include FlashHelper
  include Web::LectorsHelper
  include CustomUrlHelpers


  helper_method :edit_admin_event_cpath

  protect_from_forgery
  
end
