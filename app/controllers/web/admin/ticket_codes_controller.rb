class Web::Admin::TicketCodesController < Web::Admin::ApplicationController
  def index
    @ticket_codes = TicketCode.page(params[:page])
  end

  def new
    @ticket_codes_form = ::Admin::TicketCodeCreateType.new
    @propagators = Propagator.all
    @categories = TicketCode.categories
  end

  def create
    @propagators = Propagator.all
    @categories = TicketCode.categories
    @ticket_codes_form = ::Admin::TicketCodeCreateType.new params[:admin_ticket_code_create_type]

    if @ticket_codes_form.valid?
      codes = TicketCodeGenerator.generate(params[:admin_ticket_code_create_type])
      if TicketCode.create(codes)
        redirect_to admin_ticket_codes_path
      end
    else
      render :new
    end
  end
end
