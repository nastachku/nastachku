class Pricelist
  # TODO: зарефакторить
  def self.ticket_price
    case Time.current.strftime('%B')
    when 'February'
      750
    when 'March'
      if Time.current.day <= 3
        750
      else
        1100
      end
    when 'April'
      if Time.current.day <= 8
        1500
      else
        2000
      end
    else
      10000
    end
  end

  def self.afterparty_ticket_price
    case Time.current.strftime('%B')
    when 'February'
      1500
    when 'March'
      if Time.current.day <= 3
        1500
      else
        2000
      end
    when 'April'
      2500
    else
      10000
    end
  end
end
