class ShirtOrder < Order
  extend Enumerize

  attr_accessible :size

  validates :size, presence: true

  enumerize :size, in: [:S, :M, :L, :XL, :XXL, :XXXL]

  #FIXME найти другой вариант реализации перевода
  def to_s
    "#{I18n.t("activerecord.models.shirt_order")}(#{size})"
  end

  def cost
    self.count * configus.platidoma.shirt_price
  end

end
