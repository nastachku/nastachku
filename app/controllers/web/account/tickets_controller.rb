class Web::Account::TicketsController < Web::Account::ApplicationController
  def activation
    @code_activation_form = TicketCodeActivationType.new
  end

  def activate
    @code_activation_form = TicketCodeActivationType.new(params[:ticket_code_activation_type])

    if @code_activation_form.valid?
      ticket_code = @code_activation_form.ticket_code
      ActivateTicket.call(current_user, ticket_code)

      redirect_to edit_account_path
    else
      render :activation
    end
  end
end
