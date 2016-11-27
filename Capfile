require 'capistrano/setup'
require 'capistrano/deploy'

require 'capistrano/rbenv'
require 'capistrano/bundler'
require 'airbrake/capistrano3'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
require 'capistrano3/unicorn'
require 'capistrano-resque'
require 'capistrano-db-tasks'
require 'whenever/capistrano'

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
