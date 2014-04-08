class ReasonToGiveTicket < ActiveRecord::Migration
  def up
    add_column :users, :reason_to_give_ticket, :text
  end
end
