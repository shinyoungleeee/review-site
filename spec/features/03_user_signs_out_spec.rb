require 'rails_helper'

feature 'User signs out' do
  scenario 'user signs out successfully' do
    create(:user)

    visit new_user_session_path

    fill_in 'Email', with: 'frank@thetank.com'
    fill_in 'Password', with: 'password123'
    click_on 'Log in'
    click_on 'Sign out'

    expect(page).to have_content 'Signed out successfully.'
  end
end
