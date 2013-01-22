FactoryGirl.define do

  factory :news, :class => News do
    slug
    title
    body
  end

end