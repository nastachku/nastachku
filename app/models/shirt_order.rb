class ShirtOrder < Order
  extend Enumerize

  attr_accessible :item_size, :item_color

  validates :item_size, presence: true
  validates :item_color, presence: true

  enumerize :item_size, in: [:S, :M, :L, :XL]
  enumerize :item_color, in: [:white, :red]

  #FIXME найти другой вариант реализации перевода
  def to_s
    "#{I18n.t("activerecord.models.shirt_order")} (#{item_size}, #{item_color})"
  end

  def cost
    self.items_count * configus.platidoma.shirt_price
  end

end
