class User < ActiveRecord::Base
  include UserRepository

  attr_accessible :email,   :password, :password_digest,
                  :first_name, :last_name, :city,
                  :company, :position,
                  :show_as_participant, :photo, :state_event, :about

  mount_uploader :photo, UsersPhotoUploader 

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
    "#{last_name} #{first_name}"
  end

  def to_s
    full_name
  end

end