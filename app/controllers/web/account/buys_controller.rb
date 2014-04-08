# -*- coding: utf-8 -*-
class Web::Account::BuysController < Web::Account::ApplicationController
  def pay
    @order = current_user.orders.build
    @order.items_count = 0
    @order.cost = 0
    #FIXME вынести в метод, через current_user.send(:ticket_orders) или чтото подобное
    if params[:ticket_order]
      @ticket_order = current_user.ticket_orders.build(items_count: 1)
      @ticket_order.payment_system = "platidoma"
      if params[:discount]
        discount = Discount.find_by_code params[:discount]
        @ticket_order.discount = discount
      end
      if @ticket_order.save
        if @ticket_order.discount
          @order.cost += (@ticket_order.its_cost * @ticket_order.discount.percent) / 100
        else
          @order.cost += @ticket_order.its_cost
        end
        @order.items_count += @ticket_order.items_count
      else
        flash_error
        redirect_to edit_account_path
      end
    end

    if params[:afterparty_order]
      @afterparty_order = current_user.afterparty_orders.build(items_count: 1)
      @afterparty_order.payment_system = "platidoma"
      if @afterparty_order.save
        @order.cost += @afterparty_order.its_cost
        @order.items_count += @afterparty_order.items_count
      else
        flash_error
        redirect_to edit_account_path
      end
    end


    if @order.save
      redirect_to build_payment_curl @order
    else
      redirect_to edit_account_path
    end
  end

  def ticket
    @order = current_user.orders.build
    @order.items_count = 0
    @order.cost = 0
    #FIXME вынести в метод, через current_user.send(:ticket_orders) или чтото подобное
    @ticket_order = current_user.ticket_orders.build(items_count: 1)
    if @ticket_order.save
      @order.cost += @ticket_order.its_cost
      @order.items_count += @ticket_order.items_count
    else
      flash_error
      redirect_to root_path
    end
    if @order.save
      redirect_to build_payment_curl @order
    else
      redirect_to root_path
    end
  end
  def afterparty
    @order = current_user.orders.build
    @order.items_count = 0
    @order.cost = 0
    #FIXME вынести в метод, через current_user.send(:ticket_orders) или чтото подобное
    @afterparty_order = current_user.afterparty_orders.build(items_count: 1)
    if @afterparty_order.save
      @order.cost += @afterparty_order.its_cost
      @order.items_count += @afterparty_order.items_count
    else
      flash_error
      redirect_to root_path
    end
    if @order.save
      redirect_to build_payment_curl @order
    else
      redirect_to root_path
    end
  end
end
