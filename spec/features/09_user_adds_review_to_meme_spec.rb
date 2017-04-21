require 'rails_helper'

feature 'users can add a review to a meme' do
  scenario 'users adds new meme successfully' do
    meme = create(:meme)

    visit meme_path(meme)
    expect(page).to have_content 'Review this Meme'

    fill_in 'Rating', with: 9
    fill_in 'Body', with: 'Pretty good meme'
    click_button 'Add Review'

    expect(page).to have_content 'Review added successfully'
    expect(page).to have_content 9
    expect(page).to have_content 'Pretty good meme'
  end

  scenario 'user does not provide proper information for a review' do

    aliens_url = 'http://i3.kym-cdn.com/photos/images/newsfeed/000/158/326/9148130.jpg'
    ancient_aliens = Meme.create(name: 'Ancient Aliens', image_url: aliens_url, description: 'I don\'t know, therefore aliens.')

    visit meme_path(ancient_aliens)

    click_button 'Add Review'
    expect(page).to have_content 'Rating can\'t be blank, Rating is not a number'
  end

  scenario 'user does not enter an integer for rating' do

    aliens_url = 'http://i3.kym-cdn.com/photos/images/newsfeed/000/158/326/9148130.jpg'
    ancient_aliens = Meme.create(name: 'Ancient Aliens', image_url: aliens_url, description: 'I don\'t know, therefore aliens.')

    visit meme_path(ancient_aliens)

    fill_in 'Rating', with: "Q"

    click_button 'Add Review'
    expect(page).to have_content 'Rating is not a number'
  end

end
