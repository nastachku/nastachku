module HallRepository
  extend ActiveSupport::Concern

  include UsefullScopes

  included do
    scope :web, -> { asc_by_created_at }
    scope :activated, -> { where state: :active }
  end

end