class TicketCode < ActiveRecord::Base
  attr_accessible :code, :distributor_id, :category, :state_event, :price, :ticket, :afterparty_ticket, :kind

  belongs_to :distributor
  has_one :ticket
  has_one :afterparty_ticket

  scope :activated, -> { where state: :active }
  scope :can_activate, -> { where state: :new }

  enum category: {
    listener: "0",
    student: "1",
    organizer: "2",
    sponsor: "3",
    vip: "4",
    speaker: "5",
    schoolboy: "6",
    participant: "7",
    media: "8",
    volunteer: "9",
    staff: "10"
  }

  # NOTE: refactor it!
  enum kind: {
    conference: "ticket",
    party: "afterparty_ticket"
  }

  scope :desc_by, ->(attr) { order(attr => :desc) }
  scope :asc_by, ->(attr) { order(attr => :asc) }

  state_machine :state, initial: :new do
    state :new
    state :active
    state :canceled

    event :activate do
      transition [:new] => :active
    end

    event :cancel do
      transition any => :canceled
    end
  end

  def can_delete?
    new? && !ticket && !afterparty_ticket
  end

  def to_s
    code
  end

  def self.state_names
    state_machine.states.map(&:name)
  end
end
