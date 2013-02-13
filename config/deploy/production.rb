set :rails_env, "production"
set :branch, 'develop'
set :user, 'nastachku_production'
set :keep_releases, 5

role :web, '62.76.184.142'
role :app, '62.76.184.142'
role :db,  '62.76.184.142', :primary => true