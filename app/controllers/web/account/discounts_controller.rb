class Web::Account::DiscountsController < Web::Account::ApplicationController
  def show
    @discount = Discount.find_by_code params[:code]
    @ticket_order = TicketOrder.new
    @shirt_order = ShirtOrder.new
  end
end
