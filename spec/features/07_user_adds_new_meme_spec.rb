require 'rails_helper'

feature 'users can add memes' do
  scenario 'users adds new meme successfully' do
<<<<<<< HEAD
    user = FactoryGirl.create(:user, admin: true)
=======
    user = create(:user)
>>>>>>> master
    login_as(user, :scope => :user)

    visit new_meme_path
    expect(page).to have_content 'Submit a Meme'

    fill_in 'Name', with: 'Conspiracy Keanu'
    fill_in 'Link to Image', with: 'http://i0.kym-cdn.com/photos/images/original/000/213/844/35fimw.jpg'
    fill_in 'Description', with: 'Taken from the 1989 comedy film Bill & Ted’s Excellent Adventure'

    click_button 'Add Meme'

    expect(page).to have_content 'Meme added successfully'
    expect(page).to have_content 'Conspiracy Keanu'
    expect(page).to have_content "Contributor: #{user.username}"
    expect(page).to have_content 'Taken from the 1989 comedy film Bill & Ted’s Excellent Adventure'
  end
  scenario 'user does not provide proper information for a meme' do

    user = FactoryGirl.create(:user, admin: true)

    login_as(user, :scope => :user)

    visit new_meme_path

    click_button 'Add Meme'
    expect(page).to have_content 'Name can\'t be blank'
    expect(page).to have_content 'Image url can\'t be blank'
  end
  scenario 'user is not signed in and should NOT see new meme form' do
    visit new_meme_path

    expect(page).to have_content 'Please sign in first.'
    expect(page.first('h1')).to have_content 'Memes'
  end
end
