require 'rails_helper'

feature 'vistor sees a list of memes' do
    scenario 'sees a list of memes and link for new meme' do

      aliens_url = 'http://i3.kym-cdn.com/photos/images/newsfeed/000/158/326/9148130.jpg'
      godfather_url = 'http://i2.kym-cdn.com/photos/images/newsfeed/000/174/143/finding-nemo-blanket.jpeg'

      Meme.create(name: 'Ancient Aliens', image_url: "#{aliens_url}", description: 'therefore aliens.')
      Meme.create(name: 'Baby Godfather', image_url: "#{godfather_url}")

      visit memes_path

      expect(page).to have_content 'Ancient Aliens'
      expect(page).to have_css("img[src*='http://i3.kym-cdn.com/photos/images/newsfeed/000/158/326/9148130.jpg']")

      expect(page).to have_link 'Baby Godfather'

      click_link('Ancient Aliens')
      click_link('Baby Godfather')

      click_link 'Add New Meme!'

      expect(page).to have_content 'New Meme!'
    end


end
