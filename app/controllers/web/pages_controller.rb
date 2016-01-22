class Web::PagesController < Web::ApplicationController
  def show
    slug = params[:id]
    @meta_tags = PagesMetaService.meta_tags_for_page(slug)
    @page = Page.application.find_by!(slug: slug)
  rescue
    raise ActionController::RoutingError.new('Not Found')
  end
end
