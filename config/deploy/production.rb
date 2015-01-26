set :rails_env, "production"
set :unicorn_env, "production"
set :unicorn_pid, "#{shared_path}/pids/unicorn.pid"

set :branch, 'master'

set :user, 'nastachku'
set :keep_releases, 10

role :web, '91.239.26.221'
role :app, '91.239.26.221'
role :db,  '91.239.26.221', :primary => true

set :whenever_command, "bundle exec whenever"
require "whenever/capistrano"


after "deploy:update", "deploy:cleanup"
