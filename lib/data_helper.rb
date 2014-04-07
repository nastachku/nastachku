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

  def download_orders_in_csv(tickets_file, afterparty_file)
    750 and 1000
    1100 and 1000
    1100 and 1500
    1500 and 2000
    ticket_users = []
    afterparty_users = []
    User.includes(:orders).where(orders: {payment_state: :paid}).each do |user|
      orders = user.orders
      order = orders.select { |x| x.type == nil }.first
      ticket_order = orders.select { |x| x.type == "TicketOrder" }.first
      afterparty_order = orders.select { |x| x.type == "AfterpartyOrder" }.first
      if ticket_order and afterparty_order
        case order.cost
        when 1750
          ticket_order.cost = 750
          afterparty_order.cost = 1000
        when 2100
          ticket_order.cost = 1100
          afterparty_order.cost = 1000
        when 2600
          ticket_order.cost = 1100
          afterparty_order.cost = 1500
        when 3500          
          ticket_order.cost = 1500
          afterparty_order.cost = 2000
        end
        ticket_users << userdata_and_cost(user, ticket_order.cost)
        afterparty_users << userdata_and_cost(user, afterparty_order.cost)
      elsif ticket_order
        ticket_users << userdata_and_cost(user, order.cost)
      elsif afterparty_order
        afterparty_users << userdata_and_cost(user, order.cost)
      end   
    end
    CSV.open("ticketorders.csv", "w") do |csv|
      ticket_users.each { |i| csv << i }
    end
    CSV.open("afterpartyorders.csv", "w") do |csv|
      afterparty_users.each { |i| csv << i }
    end    
  end

  def userdata_and_cost(user, cost)
    [user.id, user.decorate.full_name, user.company, cost]
  end
end

