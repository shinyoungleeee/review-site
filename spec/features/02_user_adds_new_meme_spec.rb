require "rails_helper"

feature "users can add memes" do
  xscenario "users adds new meme successfully" do

    visit new_meme_path
    expect(page).to have_content "Submit a Meme"

    fill_in 'Name', with: "Conspiracy Keanu"
    fill_in 'Link to Image', with: "http://i0.kym-cdn.com/photos/images/original/000/213/844/35fimw.jpg"
    fill_in 'Description', with: "Taken from the 1989 comedy film Bill & Ted’s Excellent Adventure in a scene where Ted is being chased by medieval knights."

    click_button "Add Meme"

    expect(page).to have_content "Meme added successfully"
    expect(page).to have_content "Conspiracy Keanu"
    expect(page).to have_content "Taken from the 1989 comedy film Bill & Ted’s Excellent Adventure in a scene where Ted is being chased by medieval knights."
  end

  xscenario "user does not provide proper information for a meme" do
    visit new_meme_path

    click_button "Add Meme"
    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Link to Image can't be blank"
  end
end
