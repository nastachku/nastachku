require 'test_helper'

class Web::WelcomeHelperTest < ActionView::TestCase
  test "my lectures" do
    lecture = create :lecture
    assert my_lectures(LectureDecorator.decorate_collection(Lecture.all))
  end
end
