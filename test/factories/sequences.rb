FactoryGirl.define do

  sequence :email do |n|
    "email_#{n}@mail.com"
  end

  [:company, :slug, :title, :body, :photo, :description].each do |trait|
    
    sequence trait do |n|
      "#{trait}_#{n}"
    end

  end

  [:start_time, :finish_time].each do |trait|
    sequence trait do |n| 
      n.year.ago
    end
  end
  
  sequence :show_as_participant do |n|
    n % 2
  end

  sequence :process_personal_data do |n|
    true
  end

  sequence :events_attributes do |n|
    { n => FactoryGirl.attributes_for(:user_event) }
  end
end
