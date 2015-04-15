module Web::LecturesHelper
  def lecture_voted_by_current_user?(lecture, current_user_votings)
    current_user_votings.select {|voting| voting.voteable_id == lecture.id}.any?
  end

  def hidden_style(condition)
    condition ? "display: none" : ""
  end

  def current_user_feedback_for(lecture)
    feedback = lecture.feedbacks.find_by(user: current_user)
    feedback ? feedback.vote : nil
  end
end
