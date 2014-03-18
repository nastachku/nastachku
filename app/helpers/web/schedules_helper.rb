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

  def slots_in_time?(slots, time)
    slots.each do |slot|
      if slot.start_time <= time and slot.finish_time >= (time + 5.minute)
        return true
      end
    end
    return false
  end

  def minute_to_timeline(minute)
    if (minute == 0)
      "00"
    else
      minute
    end
  end
end
