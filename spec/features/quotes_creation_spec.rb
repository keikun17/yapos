require 'rails_helper'

feature "Quotes Creation" do
  include_context "Quote with 2 request and 3 offers"

  it "updates the records", js: true do
    expect(Quote.count).to eq(1)
    expect(Request.count).to eq(2)
    expect(Offer.count).to eq(3)
    expect(VendorItem.count).to eq(2)
  end

  scenario "Editing", js: true do
    visit root_path
    click_link "Client RFQ"
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
