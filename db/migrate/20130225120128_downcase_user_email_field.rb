class DowncaseUserEmailField < ActiveRecord::Migration
  def up
    User.find_each do |user|
      if user.email?
        user.email = user.email.mb_chars.downcase
        user.save
      end
    end
  end
end
