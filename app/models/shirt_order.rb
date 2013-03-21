class ShirtOrder < Order
  extend Enumerize

  attr_accessible :item_size

  validates :item_size, presence: true

  enumerize :item_size, in: [:S, :M, :L, :XL]

  #FIXME найти другой вариант реализации перевода
  def to_s
    "#{I18n.t("activerecord.models.shirt_order")} (#{item_size})"
  end

  def cost
    self.items_count * configus.platidoma.shirt_price
  end

end
