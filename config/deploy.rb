set :stages, %w(production staging)
set :default_stage, "staging"

require 'capistrano/ext/multistage'
require 'airbrake/capistrano'

set :application, "nastachku"
set :rvm_type, :system

set :scm, :git
set :repository,  "git://github.com/rocket-11/nastachku.git"

set :use_sudo, false
set :ssh_options, forward_agent: true
set :rake, "#{rake} --trace"

default_run_options[:pty] = true

namespace :cache do
  desc "Clear rails cache"
  task :clear do
    run "cd #{current_path} && RAILS_ENV=#{rails_env} #{rake} cache:clear"
  end
end

namespace :resque do
  desc "Start resque worker"
  task :start do
    run "cd #{current_path} && RAILS_ENV=#{rails_env} PIDFILE=#{shared_path}/pids/resque.pid BACKGROUND=yes QUEUE='*' #{rake} environment resque:work >> #{current_path}/log/resque_worker.log"
  end

  desc "Start resque mailer worker"
  task :mailer_start do
    run "cd #{current_path} && RAILS_ENV=#{rails_env} PIDFILE=#{shared_path}/pids/resque_mailer.pid BACKGROUND=yes QUEUE='mailer' #{rake} environment resque:work >> #{current_path}/log/resque_worker_mailer.log"
  end

  desc "Start scheduler"
  task :scheduler_start do
    run "cd #{current_path} && RAILS_ENV=#{rails_env} PIDFILE=#{shared_path}/pids/resque_scheduler.pid BACKGROUND=yes #{rake} environment resque:scheduler >> #{current_path}/log/resque_scheduler.log"
  end

  desc "Stop workers"
  task :stop do
    resque_pid = "#{shared_path}/pids/resque.pid "
    scheduler_pid = "#{shared_path}/pids/resque_scheduler.pid"
    mailer_pid = "#{shared_path}/pids/resque_mailer.pid"
    sudo "kill -2 `cat #{resque_pid}`"
    sudo "kill -2 `cat #{scheduler_pid}`"
    sudo "kill -2 `cat #{mailer_pid}`"
    run "rm -f #{resque_pid} #{scheduler_pid} #{mailer_pid}"
  end

  desc "List all resque processes."
  task :list do
    run 'ps -ef f | grep -E "[r]esque"'
  end
end

namespace :deploy do
  desc "Symlinks the database.yml"
  task :symlink_db, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end

  desc "Symlinks the credentials.yml"
  task :symlink_credentials, roles: :app do
    run "ln -nfs #{shared_path}/config/credentials.yml #{release_path}/config/credentials.yml"
  end

  desc "Symlinks the backup.rb"
  task :symlink_backup, roles: :app do
    run "ln -nfs #{shared_path}/config/backup.rb #{release_path}/config/backup.rb"
  end

  desc "Symlinks the newrelic.yml"
  task :symlink_backup, roles: :app do
    run "ln -nfs #{shared_path}/config/newrelic.yml #{release_path}/config/newrelic.yml"
  end
  desc "Seed database data"
  task :seed_data do
    run "cd #{current_path} && RAILS_ENV=#{rails_env} #{rake} db:seed"
  end

  desc "Checkout special commit"
  task :checkout, roles: :app do
    run "cd #{latest_release} && git checkout #{ENV['COMMIT']} ."
  end
end

namespace :log do
  desc "Watch tailf env log"
  task :tailf do
    stream("tailf /u/apps/#{application}/current/log/#{rails_env}.log")
  end
end


before 'deploy:finalize_update', 'deploy:symlink_db'
after 'deploy:update_code', 'deploy:checkout'
after 'deploy:symlink_db', 'deploy:symlink_backup'
after 'deploy:symlink_backup', 'deploy:symlink_credentials'
after "deploy:restart", "unicorn:stop"
after "resque:stop", "resque:start", "resque:scheduler_start"
