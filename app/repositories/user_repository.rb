module UserRepository
  extend ActiveSupport::Concern

  include UsefullScopes

  included do
    scope :web, -> { by_email }

    scope :shown_as_participants, -> {
      where show_as_participant: true
    }

    scope :alphabetically, -> { order("first_name, last_name ASC") }

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
