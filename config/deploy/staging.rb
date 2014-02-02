set :rails_env, "staging"
set :unicorn_env, "staging"
set :unicorn_pid, "#{shared_path}/pids/unicorn.pid"
set :branch, 'staging'
set :user, 'nastachku_staging'
set :keep_releases, 5

role :web, '62.76.190.226'
role :app, '62.76.190.226'
role :db,  '62.76.190.226', :primary => true

set :whenever_command, "bundle exec whenever"
require "whenever/capistrano"
