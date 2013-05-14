module UserRepository
  extend ActiveSupport::Concern

  include UsefullScopes

  included do
    scope :web, -> { by_created_at }
    scope :shown_as_participants, -> { where show_as_participant: true }
    scope :activated, -> { where state: :active }
    scope :as_lectors, -> { where role: :lector }
    scope :alphabetically, -> { asc_by_last_name }
    scope :in_carousel, -> { where in_carousel: :true }
    scope :visible, -> { where invisible_lector: :false }
    scope :nonsynchronized, -> { where timepad_state: [:unsynchronized, :failed] }

    def self.companies_by_term(company = nil)
      if company
        company = company.downcase
        self.like_by_company(company).pluck(:company).uniq
      else
        self.pluck(:company).uniq
      end
    end

    def self.cities_by_term(city = nil)
      if city
        city = city.downcase
        self.like_by_city(city).pluck(:city).uniq
      else
        self.pluck(:city).uniq
      end
    end

  end


end
