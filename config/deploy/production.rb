set :stage, :production

server 'nastachku.ru', user: 'nastachku', roles: %w{web app db resque_worker resque_scheduler}

set :branch, 'master'

set :unicorn_rack_env, 'production'
