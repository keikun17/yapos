require "rails_helper"

feature "Editing Offers from the Quote page" do
  include_context "Quote with 2 request and 3 offers"

  it "should update the quote's offer in the quote page", js: true do
    visit root_path
    click_link "Price Quotes"
    click_link "PR#0001"

    click_link "Edit Offer", match: :first # Just thest the first offer

    fill_in "Specs/Description", with: "2015 Very Heavy Bolter"
    fill_in "Actual Specs", with: "Heavy UBER Bolter 2015 model S2"

    # Vendor Item
    click_link "Input Actual Specs"
    select "Bolter", from: 'Product'

    fill_in "Weight", with: '2000'
    fill_in "Year", with: '2015'
    fill_in "Model", with: '1001'

    click_link "submit"

    fill_in "Buying Price", with: 100
    fill_in "Selling Price", with: 110

    click_button "Update Offer"
  end

  context "Filling up the PO field", js: true do

    before do
      visit root_path
      click_link "Price Quotes"
      click_link "PR#0001"

      click_link "Edit Offer", match: :first # Just the first offer

      fill_in "Client PO#", with: "PO Number 1"

      click_button "Update Offer"
    end

    it "Marks the offer and quote as purchased and Creates a PO record" do
      click_link "Client Orders"

      expect(page).to have_link("PO Number 1")

      click_link "PO Number 1"

      expect(page).to have_link("Super Seller")
      expect(page).to have_text("2014 Heavy Bolter")
      expect(page).not_to have_text("Billy light chainsaw")
      expect(page).not_to have_text("ACME Light chainsaw Variant 9001")
    end

  end
end

