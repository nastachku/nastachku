class Web::Admin::AfterpartyTicketsController < Web::Admin::ApplicationController
  def index
    query = { s: 'created_at desc' }.merge(params.fetch(:q, {}))
    @search = AfterpartyTicket.with_user.ransack(query)
    @afterparty_tickets = @search.result.page(params[:page])
  end
end
