class Web::PagesController < Web::ApplicationController

  def show
    @page = Page.find_by_slug params[:id]
  end

end