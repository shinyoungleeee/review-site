feature 'users can delete review' do
  scenario 'users deletes review successfully' do
    user = create(:user)
    login_as(user, :scope => :user)

    aliens_url = 'http://i3.kym-cdn.com/photos/images/newsfeed/000/158/326/9148130.jpg'
    ancient_aliens = Meme.create(name: 'Ancient Aliens', image_url: aliens_url, description: 'I don\'t know, therefore aliens.', contributor: user)
    review = Review.create(rating: 3, body: "fasdfgf", meme: ancient_aliens, user: user)

    visit meme_path(ancient_aliens)

    expect { click_link 'Delete Review' }.to change(Review, :count).by(-1)

    expect(page).to have_content 'Review deleted successfully'
  end
end
