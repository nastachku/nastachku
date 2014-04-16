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
end
