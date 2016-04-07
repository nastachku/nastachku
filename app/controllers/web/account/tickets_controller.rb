class Web::Account::TicketsController < Web::Account::ApplicationController
  def activation
    @code_activation_form = TicketCodeActivationType.new
  end

  def activate
    attrs = params[:ticket_code_activation_type].merge(current_user: current_user)
    @code_activation_form = TicketCodeActivationType.new(attrs)

    manage_code_activation_count

    unless can_activate_code?
      flash_error message: t('.too_frequent_activations')
      return render :activation
    end

    if @code_activation_form.valid?
      ticket_code = @code_activation_form.ticket_code
      ActivateTicketCode.call(current_user, ticket_code, cookies)

      redirect_to edit_account_path
    else
      render :activation
    end
  end
end
