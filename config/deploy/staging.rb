set :stage, :staging
server '194.177.21.104',
  user: 'nastachku',
  roles: %w(web app db resque_worker resque_scheduler)
set :branch, 'staging'
set :unicorn_rack_env, 'staging'
