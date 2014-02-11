class User::PromoCode < ActiveRecord::Base
  attr_accessible :code, :user_id

  belongs_to :user

  validates :code, presence: true,
                   length: { is: 9 }
end
