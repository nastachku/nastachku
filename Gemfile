source 'https://rubygems.org'

gem 'rails', '~> 3.2.17'
gem 'pg'
gem 'unicorn'
gem 'haml-rails'
gem 'twitter-bootstrap-rails'
gem 'jquery-ui-rails'
gem 'modernizr-rails'
gem 'less-rails'
gem 'simple_form'
gem "airbrake"
gem "mini_magick"
gem "carrierwave"
gem 'ckeditor'
gem 'jquery-rails'
gem 'bcrypt-ruby', '~> 3.0.0'
gem 'jbuilder'
gem 'unicorn-rails'
gem 'usefull_scopes'
gem 'ya_acl'
gem 'state_machine'
gem 'untranslated'
gem 'configus'
gem 'russian'
gem 'google-analytics-rails'
gem 'validates'
gem 'virtus', '>= 1.0.0'
gem 'js-routes'
gem 'backup'
gem 'whenever'
gem 'kaminari'
gem 'kaminari-bootstrap'
gem 'ransack'
gem 'chosen-rails'
gem 'select2-rails'
gem 'auditable', :github => 'harleyttd/auditable'
gem 'enumerize'
gem 'rack-rewrite'
gem 'cocoon'
gem 'gon'
gem 'redcarpet'
gem 'multi_json', '~> 1.3.0'
gem 'platidoma', '>= 0.0.4'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'mobylette'
gem 'draper'
gem 'resque', :require => 'resque/server'
gem 'resque_mailer'
gem 'resque-scheduler'
gem 'sprockets'
gem 'sinatra', '>= 1.3.0', :require => nil
gem 'newrelic_rpm'
gem 'smarter_csv'
gem 'weary'
gem 'mail_view', '~> 2.0.4'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer', :platforms => :ruby
  gem 'uglifier', '>= 1.0.3'
  gem 'compass-rails'
  gem 'turbo-sprockets-rails3'
  gem 'haml_coffee_assets'
  gem 'execjs'
end

group :test, :development do
  gem 'sqlite3'
  gem 'pre-commit'

  gem 'guard'
  gem 'dotenv-rails'
end

group :test do
  gem 'minitest'
  gem 'simplecov', :require => false
  gem 'ci_reporter'
  gem 'factory_girl_rails'
  gem 'factory_girl_sequences'
  gem 'turn'
  gem 'tconsole'
  gem "rake"
  gem 'coveralls', require: false
  gem 'mocha', require: false
  gem 'pry'
end

group :development do
  gem 'spring'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'squasher'
  gem 'foreman'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'bullet'
  gem 'bundler-audit'

  gem 'capistrano'
  gem "capistrano-resque", github: "sshingler/capistrano-resque", require: false
  gem 'rvm-capistrano'
  gem 'capistrano-ext'
  gem 'capistrano_colors'
  gem 'capi'
  gem 'capistrano-maintenance'
  gem 'ruby-prof'
end

group :development, :staging do
  gem 'timecop-console', require: 'timecop_console'
end

group :test, :darwin do
  gem 'terminal-notifier-guard', '~> 1.6.1'
end
