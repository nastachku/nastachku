require 'resque'
require 'resque/server'
require 'resque_scheduler'
require 'resque_scheduler/server'

Resque.redis = 'localhost:6379'

Resque::Mailer.excluded_environments = [:test, :cucumber]

class AsyncMailer < ActionMailer::Base
  include Resque::Mailer
end
