require 'rails_helper'

feature 'User signs in' do
  scenario 'user signs in successfully' do
    user = create(:user)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    expect(page).to have_content 'Signed in successfully.'
  end

  scenario 'user signs in with invalid info' do
    visit new_user_session_path
    click_on 'Log in'
    expect(page).to have_content 'Invalid Email or password.'

    user = create(:user)

    visit new_user_session_path
    fill_in 'Email', with: user.email
    click_on 'Log in'
    expect(page).to have_content 'Invalid Email or password.'
  end
end
