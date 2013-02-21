class DowncaseUserCityField < ActiveRecord::Migration
  def up
    User.find_each do |user|
      if user.city?
        user.city = user.city.mb_chars.downcase
        user.save validate: false
      end
    end
  end
end
