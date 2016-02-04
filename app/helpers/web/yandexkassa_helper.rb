module Web::YandexkassaHelper
  def payment_type_options
    [
      ["Кошелек в Яндекс.Деньгах", "PC"],
      ["Банковская карта", "AC"]
    ]
  end
end
