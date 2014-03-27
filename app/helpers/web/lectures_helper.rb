module Web::LecturesHelper
  def user_is_listener?(lecture)
    lecture.lecture_votings.voted_by? current_user
  end
end
