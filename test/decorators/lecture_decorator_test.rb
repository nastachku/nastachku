require 'test_helper'

class LectureDecoratorTest < Draper::TestCase
  setup do
    @lecture = (create :lecture).decorate
  end

  test "lector photo" do
    assert @lecture.lector_photo
  end

  test "lector name" do
    assert @lecture.lector_name
  end

  test "full_title" do
    assert @lecture.full_title
  end

  test "another full_title" do
    assert @lecture.another_full_title
  end
end
