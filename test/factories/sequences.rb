FactoryGirl.define do

  sequence :email do |n|
    "email_#{n}@mail.com"
  end

  [:company, :slug, :title, :body, :photo, :description, :about].each do |trait|
    
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

  sequence :image do |n|
    fixture_file_upload Rails.root.to_s + "/test/fixtures/photos/test.png", "image/png"
  end

  sequence :user_with_events do |n|
    {
        about:             FactoryGirl.generate(:about),
        photo:             FactoryGirl.generate(:image),
        events_attributes: FactoryGirl.generate(:events_attributes)
    }
  end
end
