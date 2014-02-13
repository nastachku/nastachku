class TicketOrder < Order
  extend Enumerize
  extend ActiveModel::Naming

  def cost
    configus.ticket_price
  end

  #FIXME найти другой вариант реализации перевода
  def to_s
    "#{I18n.t("activerecord.models.ticket_order")} (#{ticket_type})"
  end
end
