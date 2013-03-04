
module NewsRepository
  extend ActiveSupport::Concern

  include UsefullScopes

  included do
    scope :web, ->{by_created_at}
    scope :last3, -> { by_created_at.limit(3) }
  end
end
