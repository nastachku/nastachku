class OrderDecorator < Draper::Decorator
  delegate_all

  def in_same_minute_with?(other_order)
    model.created_at.day == other_order.created_at.day and model.created_at.hour == other_order.created_at.hour and model.created_at.to_datetime.minute == other_order.created_at.to_datetime.minute
  end

end
