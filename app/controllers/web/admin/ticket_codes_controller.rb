class Web::Admin::TicketCodesController < Web::Admin::ApplicationController
  def index
    query = { s: 'created_at desc' }.merge(params.fetch(:q, {}))
    @search = TicketCode.ransack(query)
    @ticket_codes = @search.result.page(params[:page])
  end

  def new
    @ticket_codes_form = ::Admin::TicketCodeCreateType.new
    @distributors = Distributor.all
    @categories = TicketCode.categories
    @kinds = TicketCode.kinds
  end

  def create
    @distributors = Distributor.all
    @categories = TicketCode.categories
    @kinds = TicketCode.kinds
    @ticket_codes_form = ::Admin::TicketCodeCreateType.new params[:admin_ticket_code_create_type]

    if @ticket_codes_form.valid?
      codes = TicketCodeGenerator.call(@ticket_codes_form.to_hash)
      if TicketCode.create(codes)
        redirect_to admin_ticket_codes_path
      end
    else
      render :new
    end
  end
end
