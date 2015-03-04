class Web::PagesController < Web::ApplicationController
  def show
    @page = Page.application.find_by!(slug: params[:id])
  rescue
    raise ActionController::RoutingError.new('Not Found')
  end
end
