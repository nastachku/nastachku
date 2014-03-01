class AddSocialLinksToUser < ActiveRecord::Migration
  def change
    add_column :users, :facebook, :text
    add_column :users, :vkontakte, :text
  end
end
