require 'resque'
require 'resque/server'
require 'resque/scheduler'
require 'resque/scheduler/server'

Resque.redis = 'localhost:6379'

Resque::Mailer.excluded_environments = [:test, :cucumber]

Dir["#{Rails.root}/app/jobs/*.rb"].each { |file| require file }

class AsyncMailer < ActionMailer::Base
  include Resque::Mailer
end
