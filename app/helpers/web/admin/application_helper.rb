module Web::Admin::ApplicationHelper
  def url_to_payment(order)
    case order.payment_system
    when "platidoma"
      "https://cabinet.paygate.platidoma.ru/payments/cur_month/?act=show_trans&trans_id=#{order.transaction_id}"
    when "payanyway"
      "https://www.moneta.ru/operationInfoDetails.htm?operationId=#{order.transaction_id}"
    end
  end
end
