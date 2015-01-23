
module NewsRepository
  extend ActiveSupport::Concern

  include UsefullScopes # TODO: выпилить, это настолько редко нужно, что не нужно совсем

  included do
    scope :web, -> { by_created_at }
  end
end
