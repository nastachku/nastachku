set :rails_env, "production"
set :unicorn_env, "production"
set :unicorn_pid, "#{shared_path}/pids/unicorn.pid"
set :branch do
  raise "Use tags: TAG=v2" unless ENV['TAG']
  ENV['TAG']
end
set :user, 'nastachku_production'
set :keep_releases, 5

role :web, '62.76.191.134'
role :app, '62.76.191.134'
role :db,  '62.76.191.134', :primary => true

set :whenever_command, "bundle exec whenever"
require "whenever/capistrano"
