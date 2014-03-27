module Web::LecturesHelper
  def lectures_cache_key
    ( proc {
        lecture = Lecture.web.with_active_speaker.by_listener_votes.order('updated_at DESC').limit(1).first
        {:tag => "#{lecture.updated_at.to_i}_#{params.except(:_).to_s}"}
    } ).call
  end
  
  def user_is_listener?(lecture)
    lecture.lecture_votings.voted_by? current_user
  end
end
