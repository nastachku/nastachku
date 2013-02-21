class DowncaseUserCityField < ActiveRecord::Migration
  def up
    User.all.each do |user|
      if user.city
        user.update_attributes city: user.city.downcase
      end
    end
  end
end
