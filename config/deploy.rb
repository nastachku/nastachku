set :stages, %w(production staging)
set :default_stage, "staging"

require 'capistrano/ext/multistage'
require 'airbrake/capistrano'

set :application, "nastachku_2014"
set :rvm_type, :system

set :scm, :git
set :repository,  "git://github.com/ulmic/nastachku.git"

set :use_sudo, false
set :ssh_options, forward_agent: true
set :rake, "#{rake} --trace"

default_run_options[:pty] = true

namespace :resque do
  desc "Start resque worker"
  task :start do
    run "cd #{current_path} && RAILS_ENV=#{rails_env} PIDFILE=#{shared_path}/pids/resque.pid BACKGROUND=yes QUEUE='*' #{rake} environment resque:work >> #{current_path}/log/resque_worker.log"
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

  namespace :assets do

    desc "Local precompile assets and upload to server"
    task :precompile, roles: :app do
      run_locally "git checkout #{ENV['COMMIT']} . && RAILS_ENV=#{rails_env} #{rake} assets:clean && RAILS_ENV=#{rails_env} #{rake} assets:precompile"
      run_locally "cd public && tar -jcf assets.tar.bz2 assets"
      top.upload "public/assets.tar.bz2", "#{shared_path}", via: :scp
      run "cd #{shared_path} && tar -jxf assets.tar.bz2 && rm assets.tar.bz2"
      run_locally "rm public/assets.tar.bz2"
      run_locally "#{rake} assets:clean"
      #from = source.next_revision(current_revision)
      #if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ lib/assets/ app/assets/ | wc -l").to_i > 0
      #  run_locally "RAILS_ENV=#{rails_env} #{rake} assets:clean && RAILS_ENV=#{rails_env} #{rake} assets:precompile"
      #  run_locally "cd public && tar -jcf assets.tar.bz2 assets"
      #  top.upload "public/assets.tar.bz2", "#{shared_path}", via: :scp
      #  run "cd #{shared_path} && tar -jxf assets.tar.bz2 && rm assets.tar.bz2"
      #  run_locally "rm public/assets.tar.bz2"
      #  run_locally "#{rake} assets:clean"
      #else
      #  logger.info "Skipping asset precompilation because there were no asset changes"
      #end
    end

    desc "Symlink local precompile assets"
    task :symlink, roles: :app do
      run "rm -rf #{latest_release}/public/assets &&
            mkdir -p #{latest_release}/public &&
            mkdir -p #{shared_path}/assets &&
            ln -s #{shared_path}/assets #{latest_release}/public/assets"
    end
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
before 'deploy:finalize_update', 'deploy:assets:symlink'
after 'deploy:update_code', 'deploy:checkout', 'deploy:assets:precompile'
after 'deploy:symlink_db', 'deploy:symlink_backup'
after 'deploy:symlink_backup', 'deploy:symlink_credentials'
after "deploy:restart", "unicorn:stop"
