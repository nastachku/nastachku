FactoryGirl.define do

  sequence :email do |n|
    "email_#{n}@mail.com"
  end

  sequence :items_count do |n|
    n
  end

  [:string, :company, :slug, :title, :thesises, :body, :photo, :description, :about, :color].each do |trait|
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

  sequence :lectures_attributes do |n|
    { n => FactoryGirl.attributes_for(:lecture) }
  end

  sequence :image, aliases: [:presentation] do |n|
    fixture_file_upload Rails.root.to_s + "/test/fixtures/photos/test.png", "image/png"
  end

  sequence :file do |n|
    fixture_file_upload 'users_list.csv'
  end
  sequence :user_with_lectures do |n|
    {
        about:             FactoryGirl.generate(:about),
        photo:             FactoryGirl.generate(:image),
        lectures_attributes: FactoryGirl.generate(:lectures_attributes)
    }
  end

  sequence :code do |n|
    (100000000 + n).to_s
  end
end
