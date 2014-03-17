module Web::SchedulesHelper
  def span_count(slot)
    slot.decorate.duration / 5
  end

  def time_cells_count
    480 / 5
  end
end
