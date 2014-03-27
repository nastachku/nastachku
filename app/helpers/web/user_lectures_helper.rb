module Web::UserLecturesHelper
  def user_lectures_cache_key
    ( proc {
        lecture = Lecture.voted.with_active_speaker.order('updated_at DESC').limit(1).first
        {:tag => "#{lecture.updated_at.to_i if lecture}_#{params.except(:_).to_s}_#{current_user.id}"}
    } ).call
  end
  
  def user_voted_for_lecture?(lecture)
    lecture.lecture_votings.voted_by? current_user
  end
end
