class Pricelist
  # TODO: зарефакторить
  def self.ticket_price
    990
  end

  def self.afterparty_ticket_price
    2500
  end

  private

  def self.before(year, month, day)
    Time.current.to_date < Date.new(year, month, day)
  end

  def self.at(year, month, day)
    Time.current.to_date == Date.new(year, month, day)
  end
end
