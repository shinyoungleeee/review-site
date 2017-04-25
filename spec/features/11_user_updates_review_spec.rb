require 'rails_helper'

feature 'user updates reviews' do
  scenario 'user updates reviews successfully' do
    user = create(:user)
    aliens_url = 'http://i3.kym-cdn.com/photos/images/newsfeed/000/158/326/9148130.jpg'
    ancient_aliens = Meme.create(name: 'Ancient Aliens', image_url: aliens_url, description: 'I don\'t know, therefore aliens.', contributor: user)
    review = Review.create(rating: 3, body: "fasdfgf", meme: ancient_aliens, user: user)

    visit edit_meme_review_path(ancient_aliens, review)
    expect(page).to have_content 'Edit Review!'

    fill_in 'Rating', with: 1
    fill_in 'Body', with: 'thats funny'

    click_button 'Update Review'

    expect(page).to have_content 'Review updated successfully'
    # expect(page).to have_content 'thats funny'
    # Review will appear in React.js

  end
  scenario 'user does not provide proper information for a meme' do
    user = create(:user)
    aliens_url = 'http://i3.kym-cdn.com/photos/images/newsfeed/000/158/326/9148130.jpg'
    ancient_aliens = Meme.create(name: 'Ancient Aliens', image_url: aliens_url, description: 'I don\'t know, therefore aliens.', contributor: user)
    review = Review.create(rating: 3, body: "fasdfgf", meme: ancient_aliens, user: user)

    visit edit_meme_review_path(ancient_aliens, review)
    expect(page).to have_content 'Edit Review!'

    fill_in 'Rating', with: ''
    fill_in 'Body', with: ''

    click_button 'Update Review'

    expect(page).to have_content ' Rating can\'t be blank, Rating is not a number'

  end
end
