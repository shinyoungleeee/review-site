require 'rails_helper'


feature 'visitor sees meme show page' do
  scenario 'user clicks meme name or image and sees meme title and image' do
    aliens_url = 'http://i3.kym-cdn.com/photos/images/newsfeed/000/158/326/9148130.jpg'
    godfather_url = 'http://i2.kym-cdn.com/photos/images/newsfeed/000/174/143/finding-nemo-blanket.jpeg'

    ancient_aliens = Meme.create(name: 'Ancient Aliens', image_url: aliens_url, description: 'therefore aliens.')
    baby_godfather = Meme.create(name: 'Baby Godfather', image_url: godfather_url)

    visit memes_path
    all('h3')[0].click

    expect(page).to have_content ancient_aliens.name
    expect(page).to have_css("img[src*='http://i3.kym-cdn.com/photos/images/newsfeed/000/158/326/9148130.jpg']")

    visit memes_path
    all('img')[0].click

    expect(page).to have_content ancient_aliens.name
    expect(page).to have_css("img[src*='http://i3.kym-cdn.com/photos/images/newsfeed/000/158/326/9148130.jpg']")

    visit memes_path
    all('h3')[1].click

    expect(page).to have_content baby_godfather.name
    expect(page).to have_css("img[src*='http://i2.kym-cdn.com/photos/images/newsfeed/000/174/143/finding-nemo-blanket.jpeg']")

    visit memes_path
    all('img')[1].click

    expect(page).to have_content baby_godfather.name
    expect(page).to have_css("img[src*='http://i2.kym-cdn.com/photos/images/newsfeed/000/174/143/finding-nemo-blanket.jpeg']")
  end
end
