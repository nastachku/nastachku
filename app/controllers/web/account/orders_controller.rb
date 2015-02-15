class Web::Account::OrdersController < Web::Account::ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:approve, :cancel, :decline]
  include OrderHelper

  def approve
    order = Order.find params[:pd_order_id]
    order.transaction_id = params[:pd_trans_id]
    order.save
    update_payment_state(order)
    put_paid_status_with_other_orders order
    flash_success
    redirect_to edit_account_path anchor: :my_orders
  end

  def cancel
    order = Order.find params[:pd_order_id]
    order.transaction_id = params[:pd_trans_id]
    order.save

    update_payment_state(order)
    flash_notice

    redirect_to edit_account_path anchor: :my_orders
  end

  def decline
    order = Order.find params[:pd_order_id]
    order.transaction_id = params[:pd_trans_id]
    order.save

    update_payment_state(order)
    flash_notice

    redirect_to edit_account_path anchor: :my_orders
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
      redirect_to build_payment_curl(order)
      return
    else
      flash_error
    end

    redirect_to edit_account_path anchor: :my_orders
  end
end
