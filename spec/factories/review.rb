FactoryGirl.define do
  factory :review do
    rating 10
    sequence(:body) { |n| "Review #{n}" }
    meme
    user
  end
end
