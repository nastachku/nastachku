class Web::Account::TicketsController < Web::Account::ApplicationController
  def activation
    @ticket_code = TicketCodeEditType.new
  end

  def activate
    @ticket_code = TicketCodeEditType.find_by(code: params[:ticket_code][:code])

    if @ticket_code.valid?
      TicketService.activate(@ticket_code, current_user)
      redirect_to edit_account_path
    else
      render :activation
    end
  end
end
