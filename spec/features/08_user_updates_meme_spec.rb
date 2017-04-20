require 'rails_helper'

feature 'user updates meme' do
  scenario 'user updates meme successfully' do

    aliens_url = 'http://i3.kym-cdn.com/photos/images/newsfeed/000/158/326/9148130.jpg'
    ancient_aliens = Meme.create(name: 'Ancient Aliens', image_url: aliens_url, description: 'I don\'t know, therefore aliens.')

    visit edit_meme_path(ancient_aliens)
    expect(page).to have_content 'Update a Meme'

    fill_in 'Name', with: 'Conspiracy Keanu'
    fill_in 'Link to Image', with: 'http://i0.kym-cdn.com/photos/images/original/000/213/844/35fimw.jpg'
    fill_in 'Description', with: 'Taken from the 1989 comedy film Bill & Ted’s Excellent Adventure in a scene where Ted is being chased by medieval knights.'

    click_button 'Update Meme'

    expect(page).to have_content 'Meme updated successfully'
    expect(page).to have_content 'Conspiracy Keanu'
    expect(page).to have_content 'Taken from the 1989 comedy film Bill & Ted’s Excellent Adventure in a scene where Ted is being chased by medieval knights.'
  end

  scenario 'user does not provide proper information for a meme' do
    aliens_url = 'http://i3.kym-cdn.com/photos/images/newsfeed/000/158/326/9148130.jpg'
    ancient_aliens = Meme.create(name: 'Ancient Aliens', image_url: aliens_url, description: 'I don\'t know, therefore aliens.')

    visit edit_meme_path(ancient_aliens)
    fill_in 'Name', with: ''
    fill_in 'Link to Image', with: ''
    fill_in 'Description', with: 'Taken from the 1989 comedy film Bill & Ted’s Excellent Adventure in a scene where Ted is being chased by medieval knights.'

    click_button 'Update Meme'
    expect(page).to have_content 'Name can\'t be blank'
    expect(page).to have_content 'Image url can\'t be blank'

  end

end
