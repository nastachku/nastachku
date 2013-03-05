require 'simplecov'
SimpleCov.start('rails') if ENV["COVERAGE"]

if ENV["TRAVIS"]
  require 'coveralls'
  Coveralls.wear!
end

ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  include AuthHelper
  include SocNetworkHelper

  require 'factory_girl_rails'
  include FactoryGirl::Syntax::Methods
end
