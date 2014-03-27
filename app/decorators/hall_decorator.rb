class HallDecorator < Draper::Decorator
  delegate_all

  def lectures_sorted_by_time
    model.slots
  end

  def slot_at_the_time(time)
    model.slots.for_day(time).select { |slot| slot.start_time == time }.first
  end

  def has_begin_event?(time)
    model.slots.for_day(time).select { |slot| slot.start_time == time and slot.event_type == "Event" }.any?
  end


  def has_event?(time)
    model.slots.for_day(time).select { |slot| slot.start_time < time and slot.finish_time > time and slot.event_type == "Event" }.any?
  end

  def has_begin_lecture?(time)
    model.slots.for_day(time).select { |slot| slot.start_time == time and slot.event_type == "Lecture" }.any?
  end

  def has_not_slots?(time)
    model.slots.for_day(time).select { |slot| slot.start_time < time and slot.finish_time > time }.empty?
  end

  def timeline_need_finish_event_correction?(time)
    model.slots.for_day(time).with(event_type: "Event").each do |slot|
      delta = (time.hour - slot.finish_time.hour) * 60 + (time.minute - slot.finish_time.to_datetime.minute)
      if delta >= 0 and delta < 10 and time.minute % 15 > 0 and slot.finish_time.to_datetime.minute % 15 > 0
        return true
      end
    end
    return false
  end

  def timeline_need_start_event_correction?(time)
    model.slots.for_day(time).with(event_type: "Event").each do |slot|
      delta = (slot.start_time.hour - time.hour) * 60 + (slot.start_time.to_datetime.minute - time.minute)
      if delta >= 0 and delta <= 10 and slot.start_time.to_datetime.minute % 15 > 0
        return true
      end
    end
    return false
  end

  def border_first_timeline_cell?(time)
    model.slots.for_day(time).with(event_type: "Event").each do |slot|
      delta = (time.hour - slot.finish_time.hour) * 60 + (time.minute - slot.finish_time.to_datetime.minute)
      if delta > 0 and delta <= 10 and slot.finish_time.to_datetime.minute % 15 > 0 and time.minute % 15 == 0
        return "programm__timeline__cell__without__border"
      end
    end
    return ""
  end
end
