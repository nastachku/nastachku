class TicketCode < ActiveRecord::Base
  attr_accessible :code, :distributor_id, :category, :state_event, :price

  belongs_to :distributor

  enum category: {
                    listener: 0,
                    student: 1,
                    organizer: 2,
                    sponsor: 3,
                    vip: 4,
                    speaker: 5,
                    participant: 7,
                    media: 8,
                    volunteer: 9
                  }

  state_machine :state, initial: :new do
    state :new
    state :active

    event :activate do
      transition [:new] => :active
    end
  end
end
