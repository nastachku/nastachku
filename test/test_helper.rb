require 'simplecov'
SimpleCov.start('rails') if ENV["COVERAGE"]

if ENV["TRAVIS"]
  require 'coveralls'
  Coveralls.wear!
end

ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'mocha/setup'
require 'mocha/api'

Dir[File.expand_path('../support/**/*.rb', __FILE__)].each { |f| require f }

class ActiveSupport::TestCase
  include AuthHelper
  include SocNetworkHelper

  require 'factory_girl_rails'
  include FactoryGirl::Syntax::Methods
  include TestSupport


end

include ActionDispatch::TestProcess

# def fixture_file_upload(path, mime_type = nil, binary = false)
#   fixture_path = ActionController::TestCase.fixture_path
#   Rack::Test::UploadedFile.new("#{fixture_path}#{path}", mime_type, binary)
# end
