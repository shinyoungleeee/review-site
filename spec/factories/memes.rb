FactoryGirl.define do
  factory :meme do
    sequence(:name) { |n| "Meme #{n}" }
    image_url 'http://i3.kym-cdn.com/photos/images/newsfeed/000/158/326/9148130.jpg'
    contributor
  end
end
