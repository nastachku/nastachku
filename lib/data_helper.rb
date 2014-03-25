module DataHelper
  def restore_data_from_timepad_csv(file_path)
    table =  SmarterCSV.process(file_path)
    table.each do |row|
      if row[:"'Статус'"] == "'оплачено'"
        user = User.find_by_email(row[:"'E-mail'"])
        if user
          user.pay_part
          ticket_order = user.ticket_orders.build(cost: row[:"'Сумма'"].to_s.split("'")[1].to_i, items_count: 1)
          ticket_order.created_at = row[:"'Оплатил'"].to_s.split("'")[1].to_datetime
          ticket_order.pay
          ticket_order.save
        end
      end
    end
  end
end
