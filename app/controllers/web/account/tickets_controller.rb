class Web::Account::TicketsController < Web::Account::ApplicationController
  def activation
    @code_activation_form = TicketCodeActivationType.new
  end

  def activate
    @code_activation_form = TicketCodeActivationType.new(params[:ticket_code_activation_type])

    manage_code_activation_count

    unless can_activate_code?
      flash_error message: t('.too_frequent_activations')
      return render :activation
    end

    if @code_activation_form.valid?
      ticket_code = @code_activation_form.ticket_code
      ActivateTicket.call(current_user, ticket_code)

      redirect_to edit_account_path
    else
      render :activation
    end
  end
end
