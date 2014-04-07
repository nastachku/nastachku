# -*- coding: utf-8 -*-
require 'csv'
module DataHelper
  def add_ticket_to_user(user, sum, pay_date)
    user.pay_part
    ticket_order = user.ticket_orders.build(cost: sum, items_count: 1)
    ticket_order.created_at = pay_date
    ticket_order.pay
    ticket_order.save
  end

  def restore_data_from_timepad_csv(file_path)
    table =  SmarterCSV.process(file_path)
    other_users = []
    table.map do |row|
      if row[I18n.t('timepad.data.status').to_sym] == I18n.t('timepad.data.has_paid')
        email = row[:"'e-mail'"].split("'")[1]
        user = User.find_by_email(email)
        sum = row[I18n.t('timepad.data.sum').to_sym].to_s.split("'")[1].to_i
        pay_date = row[I18n.t('timepad.data.paid').to_sym].to_s.split("'")[1].to_datetime
        if user
          add_ticket_to_user(user, sum, pay_date)
        else
          other_users << {id: email, sum: sum, pay_date: pay_date}
        end
      end
    end
    other_users
  end

  def ticket_for_other_user(id, sum, pay_date)
    user = User.find id
    add_ticket_to_user user, sum, pay_date
  end

  def tickets_for_other_users(users)
    users.each do |user|
      ticket_for_other_user(user[:id], user[:sum], user[:pay_date])
    end
  end

  def download_orders_in_csv(tickets_file="ticketorders.csv", afterparty_file="afterpartyorders.csv")
    @ticket_users = []
    @afterparty_users = []
    t_index = 1
    a_index = 1
    User.includes(:orders).where(orders: {payment_state: :paid}).each do |user|
      orders = user.orders
      order = orders.select { |x| x.type == nil }.first
      orders_count = orders.select { |x| x.type == nil }.count
      if order and orders_count == 2
        # если ктото купил билет и афтепати отдельными ордерами
        second_order = orders.select {|x| x.type == nil}.second
        order.cost = order.cost + second_order.cost
      end
      ticket_order = orders.select { |x| x.type == "TicketOrder" }.first
      afterparty_order = orders.select { |x| x.type == "AfterpartyOrder" }.first
      if ticket_order and ticket_order.cost != nil
        # from timepad
        # некоторые покупали несколько билетов на одно имя
        ticket_orders = orders.select { |x| x.type == "TicketOrder" and x.cost != nil }
        ticket_orders.each do |t|
          @ticket_users << userdata_and_cost(t_index, user, t.cost, "timepad")
          t_index = t_index + 1
        end   
      end
      if afterparty_order and afterparty_order.cost != nil
        # from timepad
        # некоторые покупали несколько афтепати на одно имя
        afterparty_orders = orders.select { |x| x.type == "AfterpartyOrder" and x.cost != nil }
        afterparty_orders.each do |a|
          @afterparty_users << userdata_and_cost(a_index, user, a.cost, "timepad")
          a_index = a_index + 1
        end   
      end
      if order
        if (ticket_order and ticket_order.cost == nil) and (afterparty_order and afterparty_order.cost == nil)
          # 750 and 1000
          # 1100 and 1000
          # 1100 and 1500
          # 1500 and 2000
          # 1500 and 2500
          case order.cost
          when 1750
            ticket_order_cost = 750
            afterparty_order_cost = 1000
          when 2100
            ticket_order_cost = 1100
            afterparty_order_cost = 1000
          when 2600
            ticket_order_cost = 1100
            afterparty_order_cost = 1500
          when 3500          
            ticket_order_cost = 1500
            afterparty_order_cost = 2000
          when 4000
            ticket_order_cost = 1500
            afterparty_order_cost = 2500
          end
          @ticket_users << userdata_and_cost(t_index, user, ticket_order_cost)
          @afterparty_users << userdata_and_cost(a_index, user, afterparty_order_cost)
          t_index = t_index + 1
          a_index = a_index + 1
        elsif ticket_order and ticket_order.cost == nil
          @ticket_users << userdata_and_cost(t_index, user, order.cost)
          t_index = t_index + 1
        elsif afterparty_order and afterparty_order.cost == nil
          @afterparty_users << userdata_and_cost(a_index, user, order.cost)
          a_index = a_index + 1
        end
      end
    end
    CSV.open(tickets_file, "w") do |csv|
      @ticket_users.each { |i| csv << i }
    end
    CSV.open(afterparty_file, "w") do |csv|
      @afterparty_users.each { |i| csv << i }
    end    
  end

  def userdata_and_cost(index, user, cost, shop="platidoma")
    [index, user.id, user.decorate.full_name, user.company, cost, shop]
  end
end

