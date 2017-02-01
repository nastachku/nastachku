class Pricelist
  # TODO: зарефакторить
  def self.ticket_price
    if before(2017, 1, 1)
      990
    elsif  before(2017, 2, 1)
      1330
    elsif before(2017, 3, 1)
      2000
    elsif before(2017, 4, 1)
      2500
    elsif before(2017, 4, 9)
      3500
    else
      4000
    end
  end

  def self.afterparty_ticket_price
    if before(2017, 1, 1)
      2500
    elsif before(2017, 4, 1)
      3000
    else
      3500
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
