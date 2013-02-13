class CreateUserAuthTokens < ActiveRecord::Migration
  def change
    create_table :user_auth_tokens do |t|
      t.integer :user_id
      t.string :authentication_token
      t.datetime :expired_at

      t.timestamps
    end
  end
end