class Web::Admin::TicketCodesController < Web::Admin::ApplicationController
  def index
    query = { s: 'id desc' }.merge(params.fetch(:q, {}))
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

  def destroy
    ticket_code = TicketCode.where(state: :new).find_by(id: params[:id])
    if ticket_code
      ticket_code.destroy
    else
      flash_error message: t('.code_is_activated')
    end
    redirect_to admin_ticket_codes_path
  end

  def show
    @ticket_code = TicketCode.find(params[:id])
    @ticket_code_activation_form = ::Admin::TicketCodeActivationType.new
  end

  def activate
    @ticket_code = TicketCode.find(params[:id])
    @ticket_code_activation_form = ::Admin::TicketCodeActivationType.new(params[:admin_ticket_code_activation_type])
    @ticket_code_activation_form.ticket_code = @ticket_code

    if @ticket_code_activation_form.valid?
      AdminTicketActivationService.new.activate_with_params(@ticket_code_activation_form.as_activation_params)
      redirect_to admin_ticket_codes_path
    else
      render :show
    end
  end
end
