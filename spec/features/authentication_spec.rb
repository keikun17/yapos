require "rails_helper"

feature "Authentication" do

  let!(:user) { create(:user, email: 'test@email.com', password: 'testpass123') }

  scenario "Signing in" do
    expect(User.count).to eq(1)
    visit root_path
    expect(page).to have_text("Sign in")

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_button "Sign in"

    expect(page).not_to have_text("Sign in")
  end

  scenario "Signing in (js: true)", js: true do
    expect(User.count).to eq(1)
    visit root_path
    expect(page).to have_text("Sign in")

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_button "Sign in"

    expect(page).not_to have_text("Sign in")
  end
end

