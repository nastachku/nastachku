class Web::Admin::AuditsController < Web::Admin::ApplicationController
  def index
    @audits = Auditable::Audit.order('created_at DESC').page(params[:page])
  end
end
