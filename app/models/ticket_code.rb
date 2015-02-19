class TicketCode < ActiveRecord::Base
  attr_accessible :code, :propagator_id, :category

  belongs_to :propagator

  enum category: [:listener, :student, :organizer, :sponsor, :vip,
                  :speaker, :participant, :media, :volunteer]
end
