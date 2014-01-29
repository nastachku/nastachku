require 'digest/md5'

class User < ActiveRecord::Base
  include UserRepository
  extend Enumerize

  attr_accessible :email, :password, :first_name, :last_name, :city, :company, :position,
    :show_as_participant, :photo, :state_event, :about, :carousel_info, :in_carousel,
    :lectures_attributes, :twitter_name, :invisible_lector, :timepad_state_event, :not_going_to_conference

  audit :email, :first_name, :last_name, :city, :company, :photo, :state, :about

  validates :email, presence: true, uniqueness: {case_sensitive: false}, email: true
  validates :first_name, length: { maximum: 255 }, russian: true
  validates :last_name, length: { maximum: 255 }, russian: true
  validates :city, length: { maximum: 255 }, russian: true
  validates :company, length: { maximum: 255 }
  validates :position, length: { maximum: 255 }

  enumerize :role, in: [ :lector, :user ], default: :user
  has_many :lectures, dependent: :destroy
  has_many :lecture_votings
  has_many :listener_votings
  has_many :orders
  has_many :shirt_orders
  has_many :afterparty_orders

  accepts_nested_attributes_for :lectures, reject_if: :all_blank, allow_destroy: true

  mount_uploader :photo, UsersPhotoUploader

  has_many :auth_tokens
  has_many :topics, through: :user_topics
  has_many :user_topics
  has_many :authorizations
  has_many :event_users
  has_many :events, through: :event_users

  state_machine :state, initial: :new do
    state :new
    state :active
    state :inactive

    event :activate do
      transition [:inactive, :new] => :active
    end

    event :deactivate do
      transition [:active, :new] => :inactive
    end
  end

  state_machine :timepad_state, initial: :unsynchronized do
    state :unsynchronized
    state :synchronized
    state :failed

    event :synchronize do
      transition [:unsynchronized, :failed] => :synchronized
    end

    event :failure do
      transition [:unsynchronized] => :failed
    end
  end


  def create_auth_token
    token = SecureHelper.generate_token
    expired_at = Time.current + configus.token.lifetime
    auth_tokens.create! :authentication_token => token, :expired_at => expired_at
  end

  def authenticate(password)
    self.password_digest == Digest::MD5.hexdigest(password)
  end

  def password=(password)
    if password.present?
      @real_password = password
      self.password_digest = Digest::MD5.hexdigest(password)
    end
  end

  def password
    @real_password
  end
end
