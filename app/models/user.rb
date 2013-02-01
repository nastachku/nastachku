class User < ActiveRecord::Base
  include UserRepository

  has_secure_password

  attr_accessible :email,   :password, :password_digest,
                  :name,    :city,
                  :company, :position,
                  :show_as_participant, :photo, :type, :state_event

  state_machine :state, initial: :active do
    state :active
    state :inactive

    event :activate do
      transition any - :active => :active
    end

    event :deactivate do
      transition :active => :inactive
    end
  end

  def full_name
    name
  end

  def to_s
    name
  end

  def member?
    false
  end

  def speaker?
    false
  end
end
