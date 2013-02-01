ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

if ENV["TRAVIS"]
  require 'coveralls'
  Coveralls.wear!
end

class ActiveSupport::TestCase
  include AuthHelper

  require 'factory_girl_rails'
  include FactoryGirl::Syntax::Methods
end
