class Web::PromoController < Web::ApplicationController
  layout "web/promo"

  def show
    @page = Page.promo.find_by!(slug: params[:id])
  rescue
    raise ActionController::RoutingError.new('Not Found')
  end
end
