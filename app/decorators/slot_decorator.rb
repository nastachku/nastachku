class SlotDecorator < Draper::Decorator
  delegate_all

  def start_hour
    model.start_time.hour
  end

  def start_offset
    model.start_time.min
  end

  def duration
    (model.finish_time - model.start_time).to_int / 60
  end

end
