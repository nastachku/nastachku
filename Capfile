load 'deploy'
require 'bundler/capistrano'
require 'rvm/capistrano'
# load 'deploy/assets'
Dir['vendor/gems/*/recipes/*.rb','vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
load 'config/deploy' # remove this line to skip loading any of the default tasks

require 'capistrano-unicorn'
