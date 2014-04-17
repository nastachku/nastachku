class SlotDecorator < Draper::Decorator
  delegate_all
  decorates_association :event

  def duration
    (model.finish_time - model.start_time).to_int / 60
  end

end
