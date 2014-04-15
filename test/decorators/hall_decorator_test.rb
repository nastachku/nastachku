require 'test_helper'

class HallDecoratorTest < Draper::TestCase
  setup do
    @hall = (create :hall).decorate
  end

  test "slots sorted by name" do
    @hall.slots << (create :slot)
    assert @hall.lectures_sorted_by_time.any?
  end
end
