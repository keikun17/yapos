require "rails_helper"

feature "Client Management" do

  before do
    sign_in('test@email.com', 'testpass123')
  end

  def sign_in(username, password)
    create(:user, email: username, password: password, password_confirmation: password)
    visit root_path

    expect(page).to have_text("Log in")

    fill_in "Email", with: "test@email.com"
    fill_in "Password", with: "testpass123"

    click_button "Log in"

    expect(page).not_to have_text("Log in")
  end

  scenario "New Client" do
    expect(Client.count).to eq(0)
    click_link "Client Records"
    click_link "New"

    fill_in "Name", with: "Super Cement"
    fill_in "client[abbrev]", with: "SC"
    fill_in "client[emails]", with: "client@email.com"
    fill_in "client[contact_numbers]",with: "123"
    fill_in "client[address]",with: "Pasig, Manila"

    click_button "Create Client"

    expect(Client.count).to eq(1)
    expect(Client.first).to have_attributes(
      name: "Super Cement",
      emails: "client@email.com",
      contact_numbers: "123",
      address: "Pasig, Manila"
    )
  end

  scenario "Edit Client" do
    create(:client, name: "Super Cement",
           abbrev: "SC",
           emails: "client@email.com",
           contact_numbers: "123",
           address: "Pasig, Manila"
          )

    click_link "Client Records"
    click_link "Super Cement"
    click_link "Edit"

    fill_in "Name", with: "Mega Cement"
    fill_in "client[abbrev]", with: "MC"
    fill_in "client[emails]", with: "megacement@email.com"
    fill_in "client[contact_numbers]",with: "355"
    fill_in "client[address]",with: "Taguig, Manila"

    click_button "Update Client"

    expect(Client.first).to have_attributes(
      name: "Mega Cement",
      emails: "megacement@email.com",
      contact_numbers: "355",
      address: "Taguig, Manila"
    )
  end
end

