module Draper
  class CollectionDecorator
    delegate :current_page, :total_pages, :limit_value
  end
end
