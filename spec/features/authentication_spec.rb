require "rails_helper"

feature "Authentication" do

  before do
    create(:user, email: 'test@email.com', password: 'testpass123', password_confirmation: 'testpass123')
  end

  scenario "Signing in" do
    visit root_path
    expect(page).to have_text("Sign in")

    fill_in "Email", with: "test@email.com"
    fill_in "Password", with: "testpass123"

    click_button "Sign in"

    expect(page).not_to have_text("Sign in")
  end
end

