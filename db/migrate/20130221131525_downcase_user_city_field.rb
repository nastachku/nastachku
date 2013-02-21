class DowncaseUserCityField < ActiveRecord::Migration
  def up
    User.find_each do |user|
      if user.city
        user.update_attributes city: user.city.downcase
      end
    end
  end
end
