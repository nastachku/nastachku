module PriceHelper
  def next_date
    # TODO: надо это выдёргивать из models/pricelist
    current_date = Time.current.to_date

    date = if current_date <= Date.new(2016, 03, 31)
             Date.new(2016, 03, 31)
           elsif current_date <= Date.new(2016, 04, 10)
             Date.new(2016, 04, 10)
           else
             nil
           end

    formatted_date = l(date, format: :date_and_month) if date
  end

  def price
    date = next_date
    price = Pricelist.ticket_price

    if date
      t('layouts.web.shared.plaha.price_upto', date: date, price: price)
    else
      t('layouts.web.shared.plaha.price', price: price)
    end
  end
end
