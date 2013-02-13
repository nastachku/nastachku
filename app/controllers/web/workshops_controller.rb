class Web::WorkshopsController < Web::ApplicationController
  def show
    @workshop = Workshop.includes(user_events: [:speaker]).find params[:id]
  end
end
