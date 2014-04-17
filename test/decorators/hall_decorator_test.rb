require 'test_helper'

class HallDecoratorTest < Draper::TestCase
  setup do
    @hall = (create :hall).decorate
  end

  test "slots sorted by name" do
    @hall.slots << (create :slot)
    assert @hall.lectures_sorted_by_time.any?
  end

  test "at this time with false" do
    @hall.slots << (create :slot)
    assert @hall.at_this_time @hall.slots.first.start_time
  end

  test "at this time with true" do
    @hall.slots << (create :slot)
    assert @hall.at_this_time (@hall.slots.first.start_time + 1.hour)
  end

  test "slot at the time" do
    @hall.slots << (create :slot)
    assert @hall.slot_at_the_time @hall.slots.first.start_time
  end

  test "slot at the time with false" do
    @hall.slots << (create :slot)
    assert_equal @hall.slot_at_the_time(Time.now), false
  end

  test "has begin event" do
    slot = create :slot
    slot.event_type = "Event"
    slot.save
    @hall.slots << slot
    assert @hall.has_begin_event? @hall.slots.first.start_time
  end

  test "has not begin event" do
    @hall.slots << (create :slot)
    assert_equal @hall.has_begin_event?(Time.now), false
  end

  test "has event" do
    slot = create :slot
    slot.event_type = "Event"
    slot.save
    @hall.slots << slot
    assert @hall.has_event?(@hall.slots.first.start_time + 1.hour)
  end

  test "has not event" do
    @hall.slots << (create :slot)
    assert_equal @hall.has_event?(Time.now), false
  end

  test "has begin lecture" do
    slot = create :slot
    slot.event_type = "Lecture"
    slot.save
    @hall.slots << slot
    assert @hall.has_begin_lecture? @hall.slots.first.start_time
  end

  test "has not begin lecture" do
    @hall.slots << (create :slot)
    assert_equal @hall.has_begin_lecture?(Time.now), false
  end

  test "has not slots" do
    @hall.slots << (create :slot)
    assert @hall.has_not_slots? Time.now
  end

  test "has slots" do
    slot = create :slot
    @hall.slots << slot
    assert_equal @hall.has_not_slots?(@hall.slots.first.start_time), false
  end

  test "timeline need finiish event correction" do
    slot = create :slot
    slot.event_type = "Event"
    slot.save
    @hall.slots << slot
    assert @hall.timeline_need_finish_event_correction? (@hall.slots.first.start_time).to_datetime
  end

  test "timeline does not need finiish event correction" do
    @hall.slots << (create :slot)
    assert_equal @hall.timeline_need_finish_event_correction?((@hall.slots.first.start_time).to_datetime), false
  end

  test "timeline need start event correction" do
    slot = create :slot
    slot.event_type = "Event"
    slot.save
    @hall.slots << slot
    assert @hall.timeline_need_start_event_correction? (@hall.slots.first.start_time).to_datetime
  end

  test "timeline does not need start event correction" do
    @hall.slots << (create :slot)
    assert_equal @hall.timeline_need_start_event_correction?((@hall.slots.first.start_time).to_datetime), false
  end

  test "border first timeline cell" do
    slot = create :slot
    slot.event_type = "Event"
    slot.finish_time += 5.minutes
    slot.save
    @hall.slots << slot
    assert_equal @hall.border_first_timeline_cell?(@hall.slots.last.finish_time.to_datetime + 10.minutes), "programm__timeline__cell__without__border"
  end

  test "empty border first timeline cell" do
    @hall.slots << (create :slot)
    assert_equal @hall.border_first_timeline_cell?((@hall.slots.first.start_time).to_datetime), ""
  end
end
