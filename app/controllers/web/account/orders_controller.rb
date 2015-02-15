class Web::Account::OrdersController < Web::Account::ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:approve, :cancel, :decline]
  include OrderHelper

  # TODO: всю логику - в сервисы!
  def approve
    order = Order.find_by number: params[:pd_order_id]
    order.transaction_id = params[:pd_trans_id]
    order.save

    update_payment_state(order)

    flash_success
    redirect_to edit_account_path anchor: :orders
  end

  def cancel
    order = Order.find_by number: params[:pd_order_id]
    order.transaction_id = params[:pd_trans_id]
    order.save

    update_payment_state(order)
    flash_notice

    redirect_to edit_account_path anchor: :orders
  end

  def decline
    order = Order.find_by number: params[:pd_order_id]
    order.transaction_id = params[:pd_trans_id]
    order.save

    update_payment_state(order)
    flash_notice

    redirect_to edit_account_path anchor: :orders
  end

  def update
    order = current_user.orders.find params[:id]

    if order
      update_payment_state(order)
      flash_success
    else
      flash_error
    end

    redirect_to edit_account_path anchor: :my_orders
  end

  def pay
    order = current_user.orders.find params[:id]

    if order.unpaid_or_declined?
      redirect_to PaymentSystem.new(:platidoma).pay_url order
      return
    else
      flash_error
    end

    redirect_to edit_account_path anchor: :orders
  end
end
