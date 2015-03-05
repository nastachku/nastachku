require 'csv'
module Data::TimepadDataHelper
  def download_orders_in_csv(paid_file="paid_users.csv")
    @paid_users = User.with_ticket.map { |user| userdata(user) }
    CSV.open(paid_file, "w") do |csv|
      @paid_users.each { |i| csv << i  }
    end
  end

  def userdata(user)
    [user.id, user.to_s, user.company]
  end
end

