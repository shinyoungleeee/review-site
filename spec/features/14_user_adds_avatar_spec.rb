require "rails_helper"

feature "avatar" do
  scenario "user uploads an avatar" do

    visit root_path
    click_link "Join"
    fill_in "First name", with: "Edward"
    fill_in "Last name", with: "ScissorHands"
    fill_in "Username", with: "mudmagic"
    fill_in "Email", with: "ash@s-mart.com"
    fill_in "Password", with: "boomstick!3vilisd3ad"
    fill_in "Password confirmation", with: "boomstick!3vilisd3ad"
    attach_file "user[avatar_url]", "#{Rails.root}/spec/support/images/photo.png"
    click_button "Sign up"

    expect(page).to have_content("Welcome! You have signed up successfully.")
    expect(page).to have_css("img[src*='photo.png']")
  end
end
