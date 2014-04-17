# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :discount do
    code "MyString"
    begin_date "2014-04-04 13:09:21"
    end_date "2014-04-04 13:09:21"
    cost 1
  end
end
