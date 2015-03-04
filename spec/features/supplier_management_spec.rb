require "rails_helper"

feature "Supplier Management" do

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

  scenario "New Supplier" do
    expect(Supplier.count).to eq(0)
    click_link "Supplier Records"
    click_link "New"

    fill_in "Name", with: "Super Rubber"
    fill_in "supplier[emails]", with: "supplier@email.com"
    fill_in "supplier[contact_numbers]",with: "123"
    fill_in "supplier[address]",with: "Pasig, Manila"

    click_button "Create Supplier"

    expect(Supplier.count).to eq(1)
    expect(Supplier.first).to have_attributes(
      name: "Super Rubber",
      emails: "supplier@email.com",
      contact_numbers: "123",
      address: "Pasig, Manila"
    )
  end

  scenario "Edit Supplier" do
    create(:supplier, name: "Super Rubber",
           emails: "client@email.com",
           contact_numbers: "123",
           address: "Pasig, Manila"
          )

    click_link "Supplier Records"
    click_link "Super Rubber"
    click_link "Edit"

    fill_in "Name", with: "Mega Rubber"
    fill_in "supplier[emails]", with: "megarubber@email.com"
    fill_in "supplier[contact_numbers]",with: "355"
    fill_in "supplier[address]",with: "Taguig, Manila"

    click_button "Update Supplier"

    expect(Supplier.first).to have_attributes(
      name: "Mega Rubber",
      emails: "megarubber@email.com",
      contact_numbers: "355",
      address: "Taguig, Manila"
    )
  end
end

