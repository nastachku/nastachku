class UsersList < ActiveRecord::Base
  attr_accessible :file, :state, :description

  mount_uploader :file, CsvUploader

  validates :file, presence: true
  validates :description, presence: true

  state_machine :state, initial: :new do
    state :new
    state :accepted

    event :accept do
      transition new: :accepted
    end
  end
end
