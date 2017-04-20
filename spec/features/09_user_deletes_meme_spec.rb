feature 'users can delete memes' do
  scenario 'users deletes meme successfully' do
    aliens_url = 'http://i3.kym-cdn.com/photos/images/newsfeed/000/158/326/9148130.jpg'
    ancient_aliens = Meme.create(name: 'Ancient Aliens', image_url: aliens_url, description: 'therefore aliens.')

    visit meme_path(ancient_aliens)
    expect(page).to have_content 'Delete Meme'

    expect { click_link 'Delete Meme' }.to change(Meme, :count).by(-1)

    expect(page).to have_content 'Meme deleted successfully'
  end
end
