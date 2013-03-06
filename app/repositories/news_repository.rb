
module NewsRepository
  extend ActiveSupport::Concern

  include UsefullScopes

  included do
    scope :web, ->{by_created_at}
    scope :last, lambda { |count| by_created_at.limit(count) }
  end
end
