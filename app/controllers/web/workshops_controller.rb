class Web::WorkshopsController < Web::ApplicationController
  def show
    @workshop = Workshop.includes(:user_events).find params[:id]
  end
end
