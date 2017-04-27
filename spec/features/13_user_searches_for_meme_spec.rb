require 'rails_helper'

feature 'users can add memes' do
  scenario 'users adds new meme successfully' do
    user = FactoryGirl.create(:user, admin: true)
    login_as(user, scope: :user)
    aliens_url = 'http://i3.kym-cdn.com/photos/images/newsfeed/000/158/326/9148130.jpg'
     Meme.create(name: 'Ancient Aliens', image_url: aliens_url, description: 'I don\'t know, therefore aliens.', contributor: user)

    visit new_meme_path
    expect(page).to have_content 'Submit a Meme'

    fill_in 'Name', with: 'Conspiracy Keanu'
    fill_in 'Link to Image', with: 'http://i0.kym-cdn.com/photos/images/original/000/213/844/35fimw.jpg'
    fill_in 'Description', with: 'Taken from the 1989 comedy film Bill & Ted’s Excellent Adventure'

    click_button 'Add Meme'

    visit memes_path

    fill_in 'search', with: 'Keanu'

    click_button "Search"

    expect(page).to have_content 'Keanu'
    expect(page).to have_no_content('aliens')
  end

end
