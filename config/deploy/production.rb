set :rails_env, "production"
set :branch do
  raise "Use tags: TAG=v2" unless ENV['TAG']
  ENV['TAG']
end
set :user, 'nastachku_production'
set :keep_releases, 5

role :web, '62.76.184.142'
role :app, '62.76.184.142'
role :db,  '62.76.184.142', :primary => true

set :whenever_command, "bundle exec whenever"
require "whenever/capistrano"