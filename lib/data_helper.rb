module DataHelper
  def restore_data_from_timepad_csv(file_path)
    table =  SmarterCSV.process(file_path)
    table.each do |row|
      if row[I18n.t('ru.timepad.data.status').to_sym] == I18n.t('ru.timepad.data.has_paid')
        user = User.find_by_email(row[I18n.t('ru.timepad.data.email').to_sym])
        if user
          user.pay_part
          ticket_order = user.ticket_orders.build(cost: row[I18n.t('ru.timepad.data.sum').to_sym].to_s.split("'")[1].to_i, items_count: 1)
          ticket_order.created_at = row[I18n.t('ru.timepad.data.paid').to_sym].to_s.split("'")[1].to_datetime
          ticket_order.pay
          ticket_order.save
        end
      end
    end
  end
end
