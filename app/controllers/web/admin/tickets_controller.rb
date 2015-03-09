class Web::Admin::TicketsController < Web::Admin::ApplicationController
  def index
    query = { s: 'created_at desc' }.merge(params.fetch(:q, {}))
    @search = Ticket.with_user.ransack(query)
    @tickets = @search.result.page(params[:page])
  end

  def show
    @ticket = Ticket.find(params[:id])
  end
end
