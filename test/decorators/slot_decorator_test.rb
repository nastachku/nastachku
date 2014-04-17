require 'test_helper'

class SlotDecoratorTest < Draper::TestCase
  setup do
    @slot = (create :slot).decorate
  end

  test "duration" do
    assert @slot.duration
  end
end
