class Web::Admin::AuditsController < Web::Admin::ApplicationController
  
  def index
    query = { s: 'created_at desc' }.merge(params[:q] || {})
    @search = Auditable::Audit.ransack(query)
    @audits = @search.result.page(params[:page]).per(configus.pagination.admin_per_page)
  end

end
