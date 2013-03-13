module SlotRepository
  extend ActiveSupport::Concern
  include UsefullScopes

  included do
    scope :web, ->{ asc_by_start_time }
    scope :for_day, lambda { |date| where(start_time: date.beginning_of_day..date.end_of_day) }
  end
end
