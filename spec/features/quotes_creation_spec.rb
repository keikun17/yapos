require 'rails_helper'

feature "Quotes Creation" do
  before do
    create(:supplier, name: "Super Seller")
    create(:supplier, name: "ACME")
    create(:client, name: "Blue Buyers", abbrev: "BBuy")

    create(:ar_belt)

    logged_as_default_user
  end

  scenario "Creating a Quote with 2 requests and 3 offers \
  (1 offer for the first request and  \
  2 offers for the second request)", js: true do
    expect(Quote.count).to eq(0)

    visit root_path

    click_link "Client RFQ"
    click_link "New Quote"

    fill_in "Client PR#", with: "PR#0001"
    select "Blue Buyers", from: "Client"

    fill_in "Signatory", with: "Jack"
    fill_in "Signatory position", with: "Sparrow"

    within(page.all(".request-line")[0]) do
      fill_in 'Item#', with: '1'
      fill_in 'Quantity', with: '100'
      fill_in 'Unit', with: 'meter'

      fill_in 'Request Specs', with: 'heavy bolter'
      fill_in 'Item/Material Code', with: 'HVB-001'
    end

    within(page.all(".offer-controls")[0]) do
      click_link "Offer"
    end

    # Offer #1 for Request #1
    within(page.all(".offer-line")[0]) do
      select "Super Seller", from: 'Brand'
      fill_in "Specs/Description", with: "2014 Heavy Bolter"
      fill_in "Actual Specs", with: "Heavy Bolter 2014 model S1"

      click_link "Input Actual Specs"
      select "Abrasive Resistant Belt", from: 'Product'


      fill_in "Width", with: '1000'
      fill_in "EP", with: '200'
      fill_in "X or /", with: 'X'
      fill_in "ply", with: '3'
      fill_in "Top Cover", with: '5'
      fill_in "Bottom Cover", with: '2'
      fill_in "Resistance", with: 'GRADE-M'

      click_link "submit"

      select "US$", from: 'Currency'
      fill_in "Exchange Rate", with: 43
      fill_in "VAT Status", with: "VAT EX"
      fill_in "Supplier Price", with: 90
      fill_in "Our Price", with: 100
      fill_in "Price Basis", with: "FOB JAPAN"

      fill_in "Terms", with: "30 days"
      fill_in "Delivery", with: "60 days"
      fill_in "Warranty", with: "1 year"
      fill_in "Notes", with: "Comes with free drillbits"
    end


    click_link "Request Item"

    # within(".request-line:eq(2)") do
    within(page.all(".request-line")[1]) do
      fill_in 'Item#', with: '2'
      fill_in 'Quantity', with: '200'
      fill_in 'Unit', with: 'meter'
      fill_in 'Request Specs', with: 'lighth chainsaw'
      fill_in 'Item/Material Code', with: 'LCS-001'
    end

    within(page.all(".offer-controls")[1]) do
      click_link "Offer"
    end

    # First offer for Request #2
    within(page.all(".offer-line")[1]) do
      select "Super Seller", from: 'Brand'
      fill_in "Specs/Description", with: "light chainsaw"
      fill_in "Actual Specs", with: "Billy light chainsaw"
      # select "BLCSW", from: "Vendor Item Code"

      select "US$", from: 'Currency'
      fill_in "Exchange Rate", with: 43
      fill_in "VAT Status", with: "VAT EX"
      fill_in "Supplier Price", with: 50
      fill_in "Our Price", with: 60
      fill_in "Price Basis", with: "FOB JAPAN"

      fill_in "Terms", with: "30 days"
      fill_in "Delivery", with: "60 days"
      fill_in "Warranty", with: "1 year"
      fill_in "Notes", with: "Batteries not included"
    end

    within(page.all(".offer-controls")[1]) do
      click_link "Offer"
    end

    # Second Offer for Request #2
    within(page.all(".offer-line")[2]) do
      select "ACME", from: 'Brand'
      fill_in "Specs/Description", with: "light chainsaw"
      fill_in "Actual Specs", with: "ACME Light chainsaw Variant 9001"
      # select  "ACME-LIGHTCHAINSAW-9001", from: "Vendor Item Code"

      fill_in "VAT Status", with: "VAT INC"
      fill_in "Supplier Price", with: 4300
      fill_in "Our Price", with: 5000
      fill_in "Price Basis", with: "FOB PIER"

      fill_in "Terms", with: "60 days"
      fill_in "Delivery", with: "30 days"
      fill_in "Warranty", with: "2 years"
      fill_in "Notes", with: "Includes charger"
    end

    click_button "Create Quote"

    expect(Quote.count).to eq(1)
    expect(Request.count).to eq(2)
    expect(Offer.count).to eq(3)
  end
end
