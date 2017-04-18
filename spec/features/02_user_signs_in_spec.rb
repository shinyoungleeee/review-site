require 'rails_helper'

feature 'User signs in' do
 scenario 'user signs in successfully' do
   create(:user)

   visit new_user_session_path

   fill_in 'Email', with: 'frank@thetank.com'
   fill_in 'Password', with: 'password123'
   click_on 'Log in'

   expect(page).to have_content 'Signed in successfully.'
 end

 scenario 'user signs in with invalid info' do
   visit new_user_session_path
   click_on 'Log in'
   expect(page).to have_content 'Invalid Email or password.'

   create(:user)

   visit new_user_session_path
   fill_in 'Email', with: 'frank@thetank.com'
   click_on 'Log in'
   expect(page).to have_content 'Invalid Email or password.'
 end
end
