class AfterpartyOrder < Order

  #FIXME найти другой вариант реализации перевода
  def to_s
    "#{I18n.t("activerecord.models.afterparty_order")}"
  end

  def cost
    self.items_count * configus.platidoma.afterparty_pricem
  end

end
