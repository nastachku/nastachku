class AdminTicketActivationService
  def initialize(user = nil)
    @user = user
  end

  def activate_code(code)
    ticket_code = TicketCode.can_activate.find_by(code: code)
    @user.transaction do
      case ticket_code.kind
      when "conference"
        if @user.ticket.present?
          @user.ticket.cancel
        end
        ticket = @user.build_ticket
      when "party"
        if @user.afterparty_ticket.present?
          @user.afterparty_ticket.cancel
        end
        ticket = @user.build_afterparty_ticket
      end

      ticket.ticket_code = ticket_code
      ticket.price = ticket_code.price
      ticket.save && ticket_code.activate
    end
  end

  def activate_with_params(params)
    @user = case params[:user_id].present?
            when true
              User.find(params[:user_id])
            when false
              UserStubType.create!(first_name: params[:first_name], last_name: params[:last_name], email: params[:email])
            end

    activate_code(params[:code])
  end
end
