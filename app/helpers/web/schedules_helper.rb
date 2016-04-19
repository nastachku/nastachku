module Web::SchedulesHelper
  def span_count(slot)
    slot.decorate.duration / 5
  end

  def time_cells_count
    480 / 5
  end

  def time_first_day(hour, minutes)
    DateTime.new(2016, 4, 22, hour, minutes, 0)
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

  def day_selected(day)
    if conference_is_going?
      if day.to_date == configus.now_time.to_date
        "selected"
      else
        ""
      end
    else
      if day.to_date == configus.schedule.first_day.date
        "selected"
      else
        ""
      end
    end

  end

  def conference_is_going?
    configus.now_time.to_date == configus.schedule.first_day.date ||
      configus.now_time.to_date == configus.schedule.second_day.date
  end

  include WorkshopsHelper

  def workshop_color(workshop_title)
    Workshop.find_by(title: workshop_title).color
  end

  def minutes_count(time)
    time.hour * 60 + time.to_datetime.minute
  end

  def before_after_party?(time, lectures_slots)
    last_lecture_finish_time = time
    lectures_slots.each do |slot|
      last_lecture_finish_time = slot.finish_time if slot.finish_time > last_lecture_finish_time
    end
    last_lecture_finish_time == time
  end

  def schedule_cache_key
    ( proc {
      hall = Hall.activated.order('updated_at DESC').limit(1).first
      curr_user_id = current_user ? "1" : "0"
      {tag: "#{hall.updated_at.to_i if hall}_#{curr_user_id}"}
    } ).call
  end

  def current_user_not_going_to_conference?
    not signed_in? or (current_user.not_paid_part? if signed_in?)
  end

  def current_day_of_conference?(day)
    day.day == DateTime.now.day
  end
end
