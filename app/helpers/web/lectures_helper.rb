module Web::LecturesHelper
  def user_is_listener?(lecture)
    #FIXME пофиксить метод vote_by, который работает с точностью да наоборот
    not lecture.lecture_votings.vote_by current_user
  end
end
