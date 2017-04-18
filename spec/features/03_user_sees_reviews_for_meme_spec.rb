require 'rails_helper'


feature 'visitor sees list of reviews on meme page' do
  xscenario 'sees reviews for specific meme' do
    ancient_aliens = Meme.create(name: 'Ancient Aliens', img_url: 'http://i3.kym-cdn.com/photos/images/newsfeed/000/158/326/9148130.jpg', description: 'I don't know, therefore aliens.')

    review_for_ancient_aliens = Review.create(rating: 4, body: 'The pork and leek is my favorite as I think it's a bit juicier than the other options', meme: ancient_aliens)

    visit meme_path(ancient_aliens)

    expect(page).to have_content ancient_aliens.name
    expect(page).to have_content review_for_ancient_aliens.rating
    expect(page).to have_content review_for_ancient_aliens.body
    expect(page).to have_content rreview_for_ancient_aliens.created_at.strftime('%B %d %Y')
  end

  xscenario 'does not see other reviews for other memes' do
    ancient_aliens = Meme.create(name: 'Ancient Aliens', img_url: 'http://i3.kym-cdn.com/photos/images/newsfeed/000/158/326/9148130.jpg', description: 'I don\'t know, therefore aliens.')
    baby_godfather = Meme.create(name: 'Baby Godfather', img_url: 'http://i2.kym-cdn.com/photos/images/newsfeed/000/174/143/finding-nemo-blanket.jpeg')
    review_for_ancient_aliens = Review.create(rating: 4, body: 'The pork and leek is my favorite as I think it is a bit juicier than the other options', meme: ancient_aliens)
    review_for_baby_godfather = Review.create(rating: 5, body: 'Get the nachos!', meme: baby_godfather)

    visit meme_path(baby_godfather)

    expect(page).to have_content baby_godfather.name
    expect(page).to have_content review_for_baby_godfather.body

    expect(page).not_to have_content ancient_aliens.name
    expect(page).not_to have_content review_for_ancient_aliens.rating
    expect(page).not_to have_content review_for_ancient_aliens.body
  end
end