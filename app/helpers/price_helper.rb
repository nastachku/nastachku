module PriceHelper
  def next_date
    # TODO: надо это выдёргивать из models/pricelist
    current_date = Time.current.to_date

    date = if current_date < Date.new(2017, 1, 1)
             Date.new(2017, 1, 1)
           elsif current_date < Date.new(2017, 2, 15)
             Date.new(2017, 2, 15)
           elsif current_date < Date.new(2017, 3, 1)
             Date.new(2017, 3, 1)
           elsif current_date < Date.new(2017, 4, 1)
             Date.new(2017, 4, 1)
           elsif current_date < Date.new(2017, 4, 9)
             Date.new(2017, 4, 9)
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
