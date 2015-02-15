module UserRepository
  extend ActiveSupport::Concern

  include UsefullScopes

  included do
    scope :web, -> { by_created_at }
    scope :participants, -> { where show_as_participant: true }
    scope :activated, -> { where state: :active }
    scope :as_lectors, -> { where role: :lector }
    scope :lecture_in_schedule, -> { joins(:lectures).where(lectures: {state: :in_schedule})  }
    scope :alphabetically, -> { asc_by_last_name }
    scope :in_carousel, -> { where in_carousel: :true }
    scope :visible, -> { where invisible_lector: :false }
    scope :nonsynchronized, -> { where timepad_state: [:unsynchronized, :failed] }
    scope :with_voted_or_scheduled_lectures, -> { joins(:lectures).where(lectures: {state: [:voted, :in_schedule]}) }
    scope :paid, -> { where pay_state: :paid_part }
    scope :with_badge, -> { where badge_state: :get_badge }
    scope :without_badge, -> { where badge_state: :not_get_badge }

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
