FactoryGirl.define do

  factory :news, :class => NewsEditType do
    slug
    title
    body
  end

end