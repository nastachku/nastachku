set :stage, :production
server '91.239.26.221',
  user: 'nastachku',
  roles: %w{web app db resque_worker resque_scheduler}
set :branch, 'master'
set :unicorn_rack_env, 'production'
set :rails_env, 'production'
