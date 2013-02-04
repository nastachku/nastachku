require 'simplecov'
SimpleCov.start('rails') if ENV["COVERAGE"]

require 'coveralls'
Coveralls.wear!

ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  include AuthHelper

  require 'factory_girl_rails'
  include FactoryGirl::Syntax::Methods
end
