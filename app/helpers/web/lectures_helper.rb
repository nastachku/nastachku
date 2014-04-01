module Web::LecturesHelper
  def user_is_listener?(lecture)
    lecture.lecture_votings.voted_by? current_user
  end

  def lecture_voted_by_current_user(lecture, current_user_votings)
    current_user_votings.select {|voting| voting.voteable_id == lecture.id}.any?
  end
end
