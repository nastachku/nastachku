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

  def day_selected(day)
    if DateTime.now > DateTime.new(2014, 4, 11, 18, 0, 0)
      if day.day == configus.schedule.first_day.date.day
        ""
      elsif day.day == configus.schedule.second_day.date.day
      "selected"
      end
    elsif day.day == configus.schedule.first_day.date.day
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
      {tag: "#{hall.updated_at.to_i if hall}_#{current_user.id if current_user}"}
    } ).call
  end

  def my_program_slots
    ids = []
    current_user.lecture_votings.each { |vote| ids << vote.voteable_id }
    ids
  end

  def current_user_not_going_to_conference?
    not signed_in? or (current_user.not_paid_part? if signed_in?)
  end
end
