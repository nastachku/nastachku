class AfterpartyOrder < Order
  attr_accessible :order_option_id
  belongs_to :order_option

  #FIXME найти другой вариант реализации перевода
  def to_s
    "#{I18n.t("activerecord.models.afterparty_order")}"
  end

  def its_cost
    self.items_count * configus.platidoma.afterparty_price
  end

end
