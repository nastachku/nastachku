module Web::LecturesHelper
  def lecture_voted_by_current_user?(lecture, current_user_votings)
    current_user_votings.select {|voting| voting.voteable_id == lecture.id}.any?
  end
end
