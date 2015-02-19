class Web::Admin::TicketCodesController < Web::Admin::ApplicationController
  def index
    query = { s: 'created_at desc' }.merge(params[:q] || {})
    @search = TicketCode.ransack(query)
    @ticket_codes = @search.result.page(params[:page])
  end

  def new
    @ticket_codes_form = ::Admin::TicketCodeCreateType.new
    @distributors = Distributor.all
    @categories = TicketCode.categories
  end

  def create
    @distributors = Distributor.all
    @categories = TicketCode.categories
    @ticket_codes_form = ::Admin::TicketCodeCreateType.new params[:admin_ticket_code_create_type]

    if @ticket_codes_form.valid?
      codes = TicketCodeGenerator.call(params[:admin_ticket_code_create_type])
      if TicketCode.create(codes)
        redirect_to admin_ticket_codes_path
      end
    else
      render :new
    end
  end
end
