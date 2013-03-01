require 'digest/md5'

class User < ActiveRecord::Base
  include UserRepository
  extend Enumerize

  attr_accessible :email, :password,
                  :first_name, :last_name, :city,
                  :company, :position,
                  :show_as_participant,
                  :photo, :state_event, :about, :carousel_info, :events_attributes

  audit :email, :first_name, :last_name, :city, :company, :photo, :state, :about

  validates :email, presence: true, uniqueness: {case_sensitive: false}, email: true
  validates :first_name, length: { maximum: 255 }, russian: true
  validates :last_name, length: { maximum: 255 }, russian: true
  validates :city, length: { maximum: 255 }, russian: true
  validates :company, length: { maximum: 255 }
  validates :position, length: { maximum: 255 }

  enumerize :role, in: [ :lector, :user ], default: :user
  has_many :events, class_name: 'UserEvent', foreign_key: 'speaker_id', dependent: :destroy
  has_many :lecture_votings
  has_many :listener_votings

  accepts_nested_attributes_for :events, :reject_if => :all_blank, :allow_destroy => true

  mount_uploader :photo, UsersPhotoUploader 

  has_many :auth_tokens
  has_many :topics, through: :user_topics
  has_many :user_topics

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


  def create_auth_token
    token = SecureHelper.generate_token
    expired_at = Time.current + configus.token.lifetime
    auth_tokens.create! :authentication_token => token, :expired_at => expired_at
  end

  def full_name
    "#{last_name} #{first_name}"
  end

  def to_s
    full_name
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

  def vote_to_event(event)
    vote(event, lecture_votings, :lecture_votings_count)
  end

  def go_to_event(event)
    vote(event, listener_votings, :listener_votings_count)
  end

  def voted_to_event?(event)
    voted?(lecture_votings, event)
  end

  def going_to_event?(event)
    voted?(listener_votings, event)
  end

  private
  def vote(voteable, association, counter)
    voting = association.where(voteable_id: voteable.id).try(:first)
    if voting
      raise "Your should have already voted! Class: #{voteable.class.name}"
    end
    voting = association.build(voteable: voteable)
    voteable.update_attribute(counter, voteable.send(counter) + 1)
    User.transaction do
      voting.save
      voteable.save
    end
  end

  def voted?(association, voteable)
    voting_count = association.where(voteable_id: voteable.id).try(:count)
    voting_count > 0
  end
end
