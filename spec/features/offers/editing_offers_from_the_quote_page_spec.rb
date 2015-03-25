require "rails_helper"

feature "Editing Offers from the Quote page", js: true do
  include_context "Quote with 2 request and 3 offers"

  it "should update the quote's offer in the quote page" do
    visit root_path
    click_link "Price Quotes"
    click_link "PR#0001"

    click_link "Edit Offer"

    fill_in "Specs/Description", with: "2015 Very Heavy Bolter"
    fill_in "Actual Specs", with: "Heavy UBER Bolter 2015 model S2"

    # Vendor Item
    click_link "Input Actual Specs"
    select "Bolter", from: 'Product'

    fill_in "Weight", with: '2000'
    fill_in "Year", with: '2015'
    fill_in "Model", with: '1001'

    click_link "submit"

    fill_in "Supplier Price", with: 100
    fill_in "Our Price", with: 110

    click_link "Update Offer"
  end

  context "Filling up the PO field", js: false do

    before do
      visit root_path
      click_link "Price Quotes"
      click_link "PR#0001"

      click_link "Edit Offer"

      fill_in "Client PO#", with: "PO Number 1"

      click_link "Update Offer"
    end

    it "Marks the offer and quote as purchased and Creates a PO record" do
      click_link "Client Orders"

      expect(page).to have_link("PO Number 1")
      click_link "PO Number 1"

      expect(page).to contain("Super Seller")
      expect(page).to contain("2014 Heavy Bolter")
      expect(page).not_to contain("Billy light chainsaw")
      expect(page).not_to contain("ACME Light chainsaw Variant 9001")
    end

  end
end

