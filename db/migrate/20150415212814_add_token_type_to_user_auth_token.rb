class AddTokenTypeToUserAuthToken < ActiveRecord::Migration
  def change
    add_column :user_auth_tokens, :token_type, :string
  end
end
