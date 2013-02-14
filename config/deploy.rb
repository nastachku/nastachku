set :stages, %w(production staging)
set :default_stage, "staging"

require 'capistrano/ext/multistage'
require 'airbrake/capistrano'

set :application, "nastachku"
set :rvm_type, :system

set :scm, :git
set :repository,  "git://github.com/kaize/nastachku.git"

set :use_sudo, false
set :ssh_options, :forward_agent => true
default_run_options[:pty] = true

namespace :deploy do
  desc "Symlinks the database.yml"
  task :symlink_db, :roles => :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  desc "Seed database data"
  task :seed_data do
    run "cd #{current_path} && RAILS_ENV=#{rails_env} #{rake} db:seed"
  end

end

before 'deploy:finalize_update', 'deploy:symlink_db'
after "deploy:update", "deploy:cleanup"
after 'deploy:restart', 'unicorn:stop'