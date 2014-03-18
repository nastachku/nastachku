module Web::SchedulesHelper
  def span_count(slot)
    slot.decorate.duration / 5
  end

  def time_cells_count
    480 / 5
  end

  def time_first_day(hour, minutes)
    DateTime.new(2014, 4, 11, hour, minutes, 0)
  end
end
