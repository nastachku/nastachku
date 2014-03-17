class HallDecorator < Draper::Decorator
  delegate_all

  def lectures_sorted_by_time
    model.slots
  end
end
