# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mail_param, :class => 'MailParams' do
    subject "MyString"
    begin_of_greetings "MyString"
    end_of_greetings "MyString"
    mail_content "MyString"
    before_link "MyString"
    after_link "MyString"
    goodbye "MyString"
    email "MyString"
    subject "MyString"
    recipient_name "MyString"
  end
end
