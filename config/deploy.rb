lock '3.3.5'

set :application, 'nastachku'
set :repo_url, 'git@github.com:rocket-11/nastachku.git'

set :deploy_to, "/u/apps/#{fetch :application}"
set :keep_releases, 10
set :log_level, :info

set :rbenv_type, :user
set :rbenv_ruby, '2.2.0'
set :rbenv_map_bins, %w(rake gem bundle ruby rails)

set :ssh_options, forward_agent: true

set :pty, true

set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/credentials.yml', 'config/secrets.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

set :unicorn_pid, -> { File.join(shared_path, "pids", "unicorn.pid") }
set :unicorn_config_path, -> { File.join(current_path, "config", "unicorn.rb") }

set :workers, '*' => 1, 'mailer' => 1
set :resque_environment_task, true
set :resque_pid_path, -> { File.join(shared_path, 'pids') }
set :resque_kill_signal, 'TERM'
set :resque_log_file, -> { File.join(current_path, 'log', 'resque_worker.log') }

after 'deploy:publishing', 'deploy:restart'
after 'deploy:finished', 'airbrake:deploy'

namespace :deploy do
  task :restart do
    invoke 'unicorn:stop'
    invoke 'unicorn:start'
    invoke 'resque:restart'
    invoke 'resque:scheduler:restart'
  end
end
