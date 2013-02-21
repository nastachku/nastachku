class Web::ApplicationController < ApplicationController  
  include AuthHelper
  include FlashHelper
  include Web::LectorsHelper

  protect_from_forgery
  
end
