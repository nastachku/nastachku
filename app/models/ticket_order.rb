# -*- coding: utf-8 -*-
class TicketOrder < Order
  extend Enumerize
  extend ActiveModel::Naming

  def its_cost
    configus.platidoma.ticket_price
  end

  #FIXME заменить TicketOrder на чтото вроде self, если возможно`
  def to_s
    TicketOrder.model_name.human
  end
end
