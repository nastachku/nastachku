if ENV["COVERAGE"]
  require 'simplecov'
  SimpleCov.start('rails') do
   add_group 'Services', 'app/services'
  end
end

if ENV["TRAVIS"]
  require 'coveralls'
  Coveralls.wear!
end

ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'mocha/setup'
require 'wrong'

Dir[File.expand_path('../support/**/*.rb', __FILE__)].each { |f| require f }

class ActiveSupport::TestCase
  include Wrong
  include AuthHelper
  include SocNetworkHelper
  require 'factory_girl_rails'
  include FactoryGirl::Syntax::Methods
  include TestSupport
end

class FactoryGirl::Syntax::Default::DSL
  include ActionDispatch::TestProcess
end
