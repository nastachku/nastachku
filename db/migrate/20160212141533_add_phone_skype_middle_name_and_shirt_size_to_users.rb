class AddPhoneSkypeMiddleNameAndShirtSizeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :phone, :string
    add_column :users, :middle_name, :string
    add_column :users, :skype, :string
    add_column :users, :shirt_size, :string
  end
end
