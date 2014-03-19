class HallDecorator < Draper::Decorator
  delegate_all

  def lectures_sorted_by_time
    model.slots
  end

  def slot_at_the_time(time)
    model.slots.each do |slot|
      if slot.start_time == time
        return slot
      end
    end
    false
  end

  def has_begin_event?(time)
    model.slots.each do |slot|
      if slot.start_time == time and slot.event_type == "Event"
        return true
      end
    end
    return false
  end


  def has_event?(time)
    model.slots.each do |slot|
      if slot.start_time < time and slot.finish_time > time and slot.event_type == "Event"
        return true
      end
    end
    return false
  end

  def has_begin_lecture?(time)
    model.slots.each do |slot|
      if slot.start_time == time and slot.event_type == "Lecture"
        return true
      end
    end
    return false
  end

  def has_not_slots?(time)
    model.slots.each do |slot|
      if slot.start_time < time and slot.finish_time > time
        return false
      end
    end
    return true
  end

  def timeline_need_finish_event_correction?(time)
    Slot.for_day(time).with(hall_id: model.id).each do |slot|
      d = (time.hour - slot.finish_time.hour) * 60 + (time.minute - slot.finish_time.to_datetime.minute)
      if d >= 0 and d < 10 and time.minute % 15 > 0 and slot.finish_time.to_datetime.minute % 15 > 0 and slot.event_type == "Event"
        return true
      end
    end
    return false
  end

  def timeline_need_start_event_correction?(time)
    Slot.for_day(time).with(hall_id: model.id).each do |slot|
      d = (slot.start_time.hour - time.hour) * 60 + (slot.start_time.to_datetime.minute - time.minute)
      if d >= 0 and d <= 10 and slot.start_time.to_datetime.minute % 15 > 0 and slot.event_type == "Event"
        return true
      end
    end
    return false
  end

  def border_first_timeline_cell?(time)
    Slot.for_day(time).with(hall_id: model.id).each do |slot|
      d = (time.hour - slot.finish_time.hour) * 60 + (time.minute - slot.finish_time.to_datetime.minute)
      if d > 0 and d <= 10 and slot.finish_time.to_datetime.minute % 15 > 0 and slot.event_type == "Event" and time.minute % 15 == 0
        return "programm__timeline__cell__without__border"
      end
    end
    return ""
  end
end
