class Web::ApplicationController < ApplicationController  
  include AuthHelper
  include FlashHelper
  include Web::LectorsHelper
  include CustomUrlHelpers
  include Web::WorkshopsHelper


  #helper :all
  helper_method :edit_admin_event_cpath, :workshops

  protect_from_forgery
  
end
