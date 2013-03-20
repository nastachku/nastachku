class Api::Lectures::ApplicationController < Api::ApplicationController

  helper_method :resource_lecture

  def resource_lecture
    Lecture.find params[:lecture_id]
  end
end