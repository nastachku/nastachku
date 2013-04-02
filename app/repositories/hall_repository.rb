module HallRepository
  extend ActiveSupport::Concern

  include UsefullScopes

  included do
    scope :web, -> { asc_by_created_at }
    scope :activated, -> { where state: :active }
    scope :by_position, -> { asc_by_position_sorting }
  end

end