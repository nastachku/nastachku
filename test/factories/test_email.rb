# coding: utf-8

FactoryGirl.define do
  factory :test_email, class: Hash do
	subject "Тема"
	begin_of_greetings "Начало приветствия"
    	end_of_greetings "Конец приветствия"
    	mail_content "Содержимое письма"
    	before_link "Перед ссылкой"
    	after_link "После ссылки"
    	goodbye "Прощание"
	
	initialize_with { attributes } 
  end
end
