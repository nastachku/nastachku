class TicketOrder < Order
  extend Enumerize
  extend ActiveModel::Naming

  attr_accessible :ticket_type, :order_option_id
  belongs_to :order_option

  enumerize :ticket_type, in: [:first, :second, :full], default: :full

  validates :ticket_type, presence: true

  def cost
    if self.ticket_type.first?
      configus.platidoma.ticket_price_first_day
    elsif self.ticket_type.second?
      configus.platidoma.ticket_price_second_day
    elsif self.ticket_type.full?
      configus.platidoma.ticket_price_first_day + configus.platidoma.ticket_price_second_day
    end
  end

  #FIXME найти другой вариант реализации перевода
  def to_s
    "#{I18n.t("activerecord.models.ticket_order")} (#{ticket_type})"
  end
end
