require 'rails_helper'

feature "Quotes Creation" do
  before do
    create(:supplier, name: "Super Seller")
    create(:client, name: "Blue Buyers", abbrev: "BBuy")

    logged_as_default_user
  end

  scenario "Quotes creation" do
    expect(Quote.count).to eq(0)

    visit root_path

    click_link "Client RFQ"
    click_link "New Quote"

    fill_in "Client PR#", with: "PR#0001"
    select "Blue Buyers", from: "Client"

    fill_in "Signatory", with: "Jack"
    fill_in "Signatory position", with: "Sparrow"

    click_button "Create Quote"

    expect(Quote.count).to eq(1)
  end
end
