class MailParams < ActiveRecord::Base
  attr_accessible :after_link, :before_link, :begin_of_greetings, :email, :end_of_greetings, :goodbye, :mail_content, :recipient_name, :subject, :subject
end
