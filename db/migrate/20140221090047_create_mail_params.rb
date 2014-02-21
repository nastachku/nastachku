class CreateMailParams < ActiveRecord::Migration
  def change
    create_table :mail_params do |t|
      t.text :subject
      t.text :begin_of_greetings
      t.text :end_of_greetings
      t.text :mail_content
      t.text :before_link
      t.text :after_link
      t.text :goodbye
      t.string :email
      t.text :subject
      t.text :recipient_name

      t.timestamps
    end
  end
end
