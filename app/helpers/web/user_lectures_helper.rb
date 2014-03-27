module Web::UserLecturesHelper
  def user_voted_for_lecture?(lecture)
    lecture.lecture_votings.voted_by? current_user
  end
end
