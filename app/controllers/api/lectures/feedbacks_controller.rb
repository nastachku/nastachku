class Api::Lectures::FeedbacksController < Api::Lectures::ApplicationController

  def create
    feedback = resource_lecture.feedbacks.find_or_initialize_by(user: current_user)
    feedback.vote = params[:vote].to_i
    unless feedback.save
      head :unprocessable_entity
    end
  end

  def destroy
    unless resource_lecture.feedbacks.unvote_by(current_user, params[:vote])
      head :unprocessable_entity
    end
  end

end
