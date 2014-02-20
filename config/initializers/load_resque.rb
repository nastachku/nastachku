require 'resque'
require 'resque/server'

Resque.redis = 'localhost:6379'

Resque::Mailer.excluded_environments = [:test, :cucumber]

class AsyncMailer < ActionMailer::Base
  include Resque::Mailer
end
