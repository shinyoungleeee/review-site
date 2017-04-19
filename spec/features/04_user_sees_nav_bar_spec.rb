require 'rails_helper'

feature 'User navigates through pages' do
  scenario 'user sees nav bar on every page' do
    visit root_path

    expect(page).to have_content 'Home'
    expect(page).to have_content 'Memes'
    expect(page).to have_content 'Categories'
    expect(page).to have_content 'Sign in'
    expect(page).to have_content 'Join'
    expect(page).to have_content 'Search'

    visit new_user_session_path

    expect(page).to have_content 'Home'
    expect(page).to have_content 'Memes'
    expect(page).to have_content 'Categories'
    expect(page).to have_content 'Sign in'
    expect(page).to have_content 'Join'
    expect(page).to have_content 'Search'

    visit new_user_registration_path
    
    expect(page).to have_content 'Home'
    expect(page).to have_content 'Memes'
    expect(page).to have_content 'Categories'
    expect(page).to have_content 'Sign in'
    expect(page).to have_content 'Join'
    expect(page).to have_content 'Search'
  end
end
