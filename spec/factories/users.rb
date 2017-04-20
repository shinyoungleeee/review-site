FactoryGirl.define do
  factory :user, aliases: [:contributor] do
    sequence(:first_name) { |n| "Frank #{n}" }
    sequence(:last_name) { |n| "Tank #{n}" }
    sequence(:username) { |n| "frankthetank#{n}" }
    sequence(:email) { |n| "frank#{n}@thetank.com" }
    password 'password'
  end
  factory :meme do
    sequence(:name) { |n| "Meme #{n}" }
    image_url 'http://i3.kym-cdn.com/photos/images/newsfeed/000/158/326/9148130.jpg'
    contributor
  end
end
