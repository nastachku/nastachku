class Web::Admin::AuditsController < Web::Admin::ApplicationController
  def index

    @search = Auditable::Audit.ransack(params[:q])
    if params[:q]
      @audits = @search.result.page(params[:page]).per(configus.pagination.admin_per_page)
    else
      @audits = @search.result.order('created_at DESC').page(params[:page]).per(configus.pagination.admin_per_page)
    end

  end
end
