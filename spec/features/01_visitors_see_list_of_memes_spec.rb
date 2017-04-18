require 'rails_helper'

feature "vistor sees a list of memes" do
    scenario "sees a list of memes and link for new meme" do

      ancient_aliens = Meme.create(name: "Ancient Aliens", image_url: "http://i3.kym-cdn.com/photos/images/newsfeed/000/158/326/9148130.jpg", description: "I don't know, therefore aliens.")
      baby_godfather = Meme.create(name: "Baby Godfather", image_url: "http://i2.kym-cdn.com/photos/images/newsfeed/000/174/143/finding-nemo-blanket.jpeg")

      visit memes_path

      expect(page).to have_content "Ancient Aliens"
      expect(page).to have_css("img[src*='http://i3.kym-cdn.com/photos/images/newsfeed/000/158/326/9148130.jpg']")

      expect(page).to have_link "Baby Godfather"

      click_link('Ancient Aliens')
      click_link('Baby Godfather')

      click_link "Add New Meme!"

      expect(page).to have_content "New Meme!"
    end


end
