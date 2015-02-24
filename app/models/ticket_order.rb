class TicketOrder < Order
  extend Enumerize
  extend ActiveModel::Naming

  attr_writer :discount

  def its_cost
    cost
  end

  def to_s
    self.class.model_name.human
  end
end
