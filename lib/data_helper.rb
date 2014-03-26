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

end

