class UsersList < ActiveRecord::Base
  attr_accessible :file, :state

  mount_uploader :file, CsvUploader

  validates :file, presence: true

  state_machine :state, initial: :new do
    state :new
    state :accepted

    event :accept do
      transition new: :accepted
    end
  end
end
