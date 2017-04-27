require "rails_helper"
feature "avatar" do
  scenario "user edits an avatar" do
    user = create(:user)
    login_as(user, :scope => :user)

    visit root_path
    click_link "Edit Profile"
    fill_in "user[current_password]", with: "password"
    attach_file "user[avatar_url]", "#{Rails.root}/spec/support/images/photo.png"
    click_button "Update"

    expect(page).to have_content("Your account has been updated successfully.")
    expect(page).to have_css("img[src*='photo.png']")
  end
end
