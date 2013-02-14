module UserRepository
  extend ActiveSupport::Concern

  include UsefullScopes

  included do
    scope :web, -> { by_email }

    scope :shown_as_participants, -> {
      where show_as_participant: true
    }

    def self.companies_by_term(company = nil)
      if company
        self.like_by_company(company).pluck(:company).uniq
      else
        self.pluck(:company).uniq
      end
    end

    scope :alphabetically, -> { order("first_name, last_name ASC") }
  end


end
