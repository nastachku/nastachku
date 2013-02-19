class Web::ApplicationController < ApplicationController  
  include AuthHelper
  include FlashHelper

  protect_from_forgery
  
end
