class Web::PagesController < Web::ApplicationController

  def show
    @page = Page.find_by_slug! params[:id]
    title @page
  rescue
    raise ActionController::RoutingError.new('Not Found')
  end

end
