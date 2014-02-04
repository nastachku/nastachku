class User::PromoCode < ActiveRecord::Base
  attr_accessible :accepted_state, :code, :user_id

  belongs_to :user

  validates :code, presence: true,
                   length: { is: 9 }
  validates :accepted_state, presence: true
  validates :user_id, presence: true

  state_machine :accepted_state, initial: :not_accepted do
    state :not_accepted
    state :accepted

    event :accept do
      transition not_accepted: :accepted
    end
  end
end
