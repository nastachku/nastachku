
class User < ActiveRecord::Base
  include UserRepository

  attr_accessible :email, :password, :password_digest,
                  :name,  :city,     :company,
                  :show_as_participant

  def full_name
    name
  end
end
