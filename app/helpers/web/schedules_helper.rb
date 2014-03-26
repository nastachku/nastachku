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

  def first_day_selected(day)
    if day.day == configus.schedule.first_day.date.day
      "selected"
    end
  end

  include WorkshopsHelper

  def workshop_color(workshop_title)
    workshops_color_hash[workshop_title]
  end

  def minutes_count(time)
    time.hour * 60 + time.to_datetime.minute
  end

  def before_after_party?(time)
    last_lecture_finish_time = time
    Slot.for_day(time).with(event_type: "Lecture").each do |slot|
      if slot.finish_time > last_lecture_finish_time
        last_lecture_finish_time = slot.finish_time
      end
    end
    last_lecture_finish_time == time
  end
end
