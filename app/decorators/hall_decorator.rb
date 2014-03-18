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
      if slot.start_time <= time and slot.finish_time >= time
        return false
      end
    end
    return true
  end
end
