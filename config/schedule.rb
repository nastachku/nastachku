# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

job_type :bundle_command, "cd :path && RAILS_ENV=#{environment} bundle exec :task"
job_type :rake, "cd :path && RAILS_ENV=#{environment} rake :task"

set :output, 'tmp/whenever.log'
set :path, "/u/apps/nastachku/current"

every 4.hours do
  # TODO: сделать обычный бэкап базы
  # bundle_command "backup perform -t nastachku_#{environment} -c config/backup.rb --root_path ."
end

every 1.hours do
  rake "app:timepad_user_synchronization"
end
