FactoryGirl.define do
  factory :user do
    first_name 'Frank'
    last_name 'Tank'
    username 'frankthetank'
    email 'frank@thetank.com'
    password 'password123'
  end
  factory :meme do
    sequence(:name) { |n| "Meme #{n}" }
    image_url 'http://i3.kym-cdn.com/photos/images/newsfeed/000/158/326/9148130.jpg'
  end
end
