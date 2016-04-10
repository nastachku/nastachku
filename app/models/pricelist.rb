class Pricelist
  # TODO: зарефакторить
  def self.ticket_price
    if before(2016, 01, 01) || at(2016, 01, 14)
      750
    elsif before(2016, 02, 01)
      1000
    elsif before(2016, 03, 01)
      1500
    elsif before(2016, 04, 01)
      2000
    elsif before(2016, 04, 13)
      2500
    elsif before(2016, 04, 24)
      3000
    else
      10000
    end
  end

  def self.afterparty_ticket_price
    if before(2016, 01, 01)
      2000
    elsif before(2016, 04, 01)
      2500
    elsif before(2016, 04, 23)
      3000
    else
      10000
    end
  end

  private

  def self.before(year, month, day)
    Time.current.to_date < Date.new(year, month, day)
  end

  def self.at(year, month, day)
    Time.current.to_date == Date.new(year, month, day)
  end
end
