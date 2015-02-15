class TicketOrder < Order
  extend Enumerize
  extend ActiveModel::Naming

  attr_writer :discount

  # TODO: перенести логику формировани цены в более удачное место
  def self.ticket_price
    case Time.current.strftime('%B')
    when 'February'
      750
    when 'March'
      1100
    when 'April'
      if Time.current.day <= 8
        1500
      else
        2000
      end
    else
      10000
    end
  end

  # FIXME: убрать это. Стоимость заказа должна быть зафиксирована на момент оплаты
  def its_cost
    self.class.ticket_price
  end

  def to_s
    self.class.model_name.human
  end
end
