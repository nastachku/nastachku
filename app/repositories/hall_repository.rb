module HallRepository
  extend ActiveSupport::Concern

  include UsefullScopes

  included do
    scope :web, -> { asc_by_created_at }
  end

end