require 'timepad'

namespace :app do

  desc "User synchronization with timepad.ru"
  task :timepad_user_synchronization => :environment do
    timepad = Timepad.new
    timepad.user_synchronization
  end

end