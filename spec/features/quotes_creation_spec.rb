require 'rails_helper'

feature "Quotes Creation", js: true do
  include_context "Quote with 2 request and 3 offers"

  it "updates the records", js: true do
    expect(Quote.count).to eq(1)
    expect(Request.count).to eq(2)
    expect(Offer.count).to eq(3)
    expect(VendorItem.count).to eq(3)
  end

end

feature "Print quotes", js: true do

  context "2 different suppliers in the quote" do
    include_context "Quote with 2 request and 3 offers"

    before do
      visit root_path
      click_link "Price Quotes"
      click_link "PR#0001"
    end

    scenario "Print all offers" do

      handle_window = window_opened_by { click_link "Print" }

      within_window(handle_window) do
        expect(page).to have_text("Blue Buyers")
        expect(page).to have_text("Jack")
        expect(page).to have_text("Sparrow")

        # request 1
        expect(page).to have_text("100.0")
        expect(page).to have_text("meter")
        expect(page).to have_text("heavy bolter")

        # binding.pry
        # request 1 offer 1
        expect(page).to have_text("Super Seller")
        expect(page).to have_text("2014 Heavy Bolter")
        expect(page).not_to have_text("Heavy Bolter 2014 model S1")
        expect(page).to have_text("US$100.00/meter (VAT EX FOB JAPAN")
        expect(page).to have_text("US$10,000.00 (VAT EX FOB JAPAN)")

        # request 2
        expect(page).to have_text("200.0")
        expect(page).to have_text("meter")
        expect(page).to have_text("lighth chainsaw")

        # request 2 offer 1
        expect(page).to have_text("Super Seller")
        expect(page).to have_text("light chainsaw")
        expect(page).not_to have_text("Billy light chainsaw")
        expect(page).to have_text("US$60.00/meter (VAT EX FOB JAPAN")
        expect(page).to have_text("US$12,000.00 (VAT EX FOB JAPAN)")

        # request 2 offer 1
        expect(page).to have_text("ACME")
        expect(page).to have_text("light chainsaw")
        expect(page).not_to have_text("ACME Light chainsaw Variant 9001")
        expect(page).to have_text("PHP5,000.00/meter (VAT INC FOB PIER)")
        expect(page).to have_text("PHP1,000,000.00 (VAT INC FOB PIER)")
      end
    end

    scenario "Print just Super Seller offers" do
      handle_window = window_opened_by { click_link "Print only Super Seller offers" }

      within_window(handle_window) do
        expect(page).to have_text("Blue Buyers")
        expect(page).to have_text("Jack")
        expect(page).to have_text("Sparrow")

        # request 1
        expect(page).to have_text("100.0")
        expect(page).to have_text("meter")
        expect(page).to have_text("heavy bolter")

        # binding.pry
        # request 1 offer 1
        expect(page).to have_text("Super Seller")
        expect(page).to have_text("2014 Heavy Bolter")
        expect(page).not_to have_text("Heavy Bolter 2014 model S1")
        expect(page).to have_text("US$100.00/meter (VAT EX FOB JAPAN")
        expect(page).to have_text("US$10,000.00 (VAT EX FOB JAPAN)")

        # request 2
        expect(page).to have_text("200.0")
        expect(page).to have_text("meter")
        expect(page).to have_text("lighth chainsaw")

        # request 2 offer 1
        expect(page).to have_text("Super Seller")
        expect(page).to have_text("light chainsaw")
        expect(page).not_to have_text("Billy light chainsaw")
        expect(page).to have_text("US$60.00/meter (VAT EX FOB JAPAN")
        expect(page).to have_text("US$12,000.00 (VAT EX FOB JAPAN)")

        # request 2 offer 1
        expect(page).not_to have_text("ACME")
        expect(page).not_to have_text("ACME Light chainsaw Variant 9001")
        expect(page).not_to have_text("PHP5,000.00/meter (VAT INC FOB PIER)")
        expect(page).not_to have_text("PHP1,000,000.00 (VAT INC FOB PIER)")
      end
    end

  end


  context "2 different suppliers in the quote, one supplier is hidden" do
    include_context "Quote with 2 request and 3 offers"

    before do
    end

    scenario "Print all offers"

    scenario "Print supplier specific"

  end


end


feature "Editing Quotes"  do
  include_context "Quote with 2 request and 3 offers"
  scenario "Editing", js: true do
    visit root_path
    click_link "Price Quotes"
    click_link "PR#0001"
    click_link "Edit", match: :first

    fill_in "Client PR#", with: "PR#0001-edited"

    within(page.all(".request-line")[0]) do
      fill_in 'Quantity', with: '105'
    end

    # Offer #1 for Request #1
    within(page.all(".offer-line")[0]) do
      select "Super Seller", from: 'Brand'
      fill_in "Specs/Description", with: "2014 Heavy Bolter"
      fill_in "Actual Specs", with: "Heavy Bolter 2014 model S2"

      # Vendor Item
      click_link "Input Actual Specs"
      select "Bolter", from: 'Product'

      fill_in "Weight", with: '2000'
      fill_in "Year", with: '2014'
      fill_in "Model", with: '1001'

      click_link "submit"

      fill_in "Supplier Price", with: 100
      fill_in "Our Price", with: 110
    end

    click_button "Update Quote"

    quote = Quote.first
    vendor_item = quote.offers.first.vendor_item
    expect(quote.quote_reference).to eq("PR#0001-edited")

    expect(vendor_item.vendor_item_fields.includes(:product_field).find_by(product_fields: {name: 'Weight'}).value).to eq('2000')
    expect(vendor_item.vendor_item_fields.includes(:product_field).find_by(product_fields: {name: 'Year'}).value).to eq('2014')
    expect(vendor_item.vendor_item_fields.includes(:product_field).find_by(product_fields: {name: 'Model'}).value).to eq('1001')
  end


end
