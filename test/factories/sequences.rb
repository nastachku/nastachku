FactoryGirl.define do

  sequence :email do |n|
    "email_#{n}@mail.com"
  end

  [:name, :city, :company].each do |trait|
    
    sequence trait do |n|
      "#{trait}_#{n}"
    end

  end

  sequence :show_as_participant do |n|
    n % 2
  end

end