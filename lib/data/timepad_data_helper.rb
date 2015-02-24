# -*- coding: utf-8 -*-
require 'csv'
module Data::TimepadDataHelper
  def restore_data_from_timepad_csv(file_path)
    # ПРОВЕРИТЬ ДОБАВЛЕНИЕ AFTERPARTY !!!11
    table =  SmarterCSV.process(file_path)
    other_users = []
    table.map do |row|
      if row[I18n.t('timepad.data.status').to_sym] == I18n.t('timepad.data.has_paid')
        email = row[:"'e-mail'"].split("'")[1]
        user = User.find_by_email(email)
        sum = row[I18n.t('timepad.data.sum').to_sym].to_s.split("'")[1].to_i
        pay_date = row[I18n.t('timepad.data.paid').to_sym].to_s.split("'")[1].to_datetime
        if user
          add_order_to_user(user, sum, pay_date, row[I18n.t('timepad.data.ticket_type')])
        else
          other_users << {id: email, sum: sum, pay_date: pay_date, type: row[I18n.t('timepad.data.ticket_type')] }
        end
      end
    end
    other_users # пользователи, которые не найдены в базе по email
    # их можно поискать ручками по имени\фамилии\должности\компании,
    # заменить id на реальный
    # и применить к массиву users функцию tickets_for_other_users(users)
  end

  def tickets_for_other_users(users)
    users.each do |user_data|
      user = User.find user_data[:id]
      add_order_to_user(user, user_data[:sum], user_data[:pay_date], user_data[:type])
    end
  end

  def add_order_to_user(user, sum, pay_date, type)
    case type
    when I18n.t('timepad.data.ticket')
      add_ticket_to_user(user, sum, pay_date)
    when I18n.t('timepad.data.afterparty')
      add_afterparty_to_user(user, sum, pay_date)
    end
  end

  def add_ticket_to_user(user, sum, pay_date)
    user.pay_part
    ticket = user.build_ticket price: sum
    ticket.created_at = pay_date
    ticket.save
  end

  def add_afterparty_to_user(user, sum, pay_date)
    afterparty_ticket = user.build_afterparty_ticket price: sum
    afterparty_ticket.created_at = pay_date
    afterparty_ticket.save
  end

  def download_orders_in_csv(tickets_file="ticketorders.csv", afterparty_file="afterpartyorders.csv", badge_file="badges.csv", paid_file="paid_users.csv")
    # NOTE: интеграция с timepad отключена. Пока этот код не нужен. Тесты он ломает, но фиксить это не вариант

    # @ticket_users = []
    # @afterparty_users = []
    # t_index = 1
    # a_index = 1
    # User.includes(:orders).where(orders: {payment_state: :paid}).order("orders.id ASC").each do |user|
    #   orders = user.orders
    #   order = orders.select { |x| x.type == nil }.first
    #   orders_count = orders.select { |x| x.type == nil }.count
    #   if order and orders_count == 2
    #     # если ктото купил билет и афтепати отдельными ордерами
    #     second_order = orders.select {|x| x.type == nil}.second
    #     order.cost = order.cost + second_order.cost
    #   end
    #   ticket_order = first_order("TicketOrder", orders)
    #   afterparty_order = first_order("AfterpartyOrder", orders)

    #   t_index = orders_from_timepad(user, t_index, @ticket_users, "TicketOrder")
    #   a_index = orders_from_timepad(user, a_index, @afterparty_users, "AfterpartyOrder")
    #   if order
    #     if ticket_order and afterparty_order
    #       # 750 and 1000
    #       # 1100 and 1000
    #       # 1100 and 1500
    #       # 1500 and 2000
    #       # 1500 and 2500
    #       case order.cost
    #       when 1750
    #         ticket_order_cost = 750
    #         afterparty_order_cost = 1000
    #       when 2100
    #         ticket_order_cost = 1100
    #         afterparty_order_cost = 1000
    #       when 2600
    #         ticket_order_cost = 1100
    #         afterparty_order_cost = 1500
    #       when 3500
    #         ticket_order_cost = 1500
    #         afterparty_order_cost = 2000
    #       when 4000
    #         ticket_order_cost = 1500
    #         afterparty_order_cost = 2500
    #       end
    #       @ticket_users << userdata_and_cost(t_index, user, ticket_order_cost)
    #       @afterparty_users << userdata_and_cost(a_index, user, afterparty_order_cost)
    #       t_index = t_index + 1
    #       a_index = a_index + 1
    #     elsif ticket_order
    #       @ticket_users << userdata_and_cost(t_index, user, order.cost)
    #       t_index = t_index + 1
    #     elsif afterparty_order
    #       @afterparty_users << userdata_and_cost(a_index, user, order.cost)
    #       a_index = a_index + 1
    #     end
    #   end
    # end
    # CSV.open(tickets_file, "w") do |csv|
    #   @ticket_users.each { |i| csv << i }
    # end
    # CSV.open(afterparty_file, "w") do |csv|
    #   @afterparty_users.each { |i| csv << i }
    # end
    # @users = []
    # User.all.select { |user| user.not_get_badge? and user.paid_part? }.each do |user|
    #   @users << userdata(user)
    # end
    # CSV.open(badge_file, "w") do |csv|
    #   @users.each { |i| csv << i  }
    # end
    # @paid_users = []
    # User.all.select { |user| user.paid_part? }.each do |user|
    #   @paid_users << userdata(user)
    # end
    # CSV.open(paid_file, "w") do |csv|
    #   @paid_users.each { |i| csv << i  }
    # end
  end

  def userdata_and_cost(index, user, cost, shop="platidoma", count=1)
    [index, user.id, user.decorate.full_name, user.company, cost, shop, count]
  end

  def userdata(user)
    [user.id, user.decorate.full_name, user.company]
  end

  def orders_from_timepad(user, index, orders_output, orders_type)
    # from timepad
    # некоторые покупали несколько билетов на одно имя
    timepad_orders = user.orders.select { |x| x.type == orders_type and x.cost != nil }
    timepad_orders_count = timepad_orders.count
    if timepad_orders_count > 0
      timepad_order = timepad_orders.first
      orders_output << userdata_and_cost(index, user, timepad_order.cost, "timepad", timepad_orders_count)
      index = index + 1
    end
    index
  end

  def first_order(type, orders)
    # cost == nil if platidoma
    # и по идее он должен быть такой один
    orders.select { |x| x.type == type and x.cost == nil }.first
  end

end

