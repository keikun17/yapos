require 'rails_helper'

feature "Quotes Creation", js: true do
  include_context "Quote with 2 request and 3 offers"

  it "updates the records" do
    expect(Quote.count).to eq(1)
    expect(Request.count).to eq(2)
    expect(Offer.count).to eq(3)
    expect(VendorItem.count).to eq(3)
  end

  it "should appear on the 'all offers' page, client's quotes and offers page and suppliers' quotes and offers page" do
    # Clients Quotes and offers
    visit root_path
    click_link "Client Records"
    click_link "Blue Buyers"
    expect(page).to have_link("PR#0001")
    expect(page).to have_text('heavy bolter')
    expect(page).to have_text('lighth chainsaw')
    click_link "Offers"
    expect(page).to have_link("PR#0001")
    expect(page).to have_text("2014 Heavy Bolter")
    expect(page).to have_text("Heavy Bolter 2014 model S1")
    expect(page).to have_text("light chainsaw")
    expect(page).to have_text("Billy light chainsaw")
    expect(page).to have_text("light chainsaw")
    expect(page).to have_text("ACME Light chainsaw Variant 9001")

    # Supplier Quotes and offers
    visit root_path
    click_link "Supplier Records"
    click_link "Super Seller"
    click_link "Awaiting Client Purchase (Sorted by Quote Date)"
    expect(page).to have_link("PR#0001")
    expect(page).to have_text("2014 Heavy Bolter")
    expect(page).to have_text("Heavy Bolter 2014 model S1")
    expect(page).to have_text("light chainsaw")
    expect(page).to have_text("Billy light chainsaw")
    expect(page).not_to have_text("ACME Light chainsaw Variant 9001")

    click_link "Client Purchased (Sorted by Order Date)"
    expect(page).not_to have_link("PR#0001")
    expect(page).not_to have_text("2014 Heavy Bolter")
    expect(page).not_to have_text("Heavy Bolter 2014 model S1")
    expect(page).not_to have_text("light chainsaw")
    expect(page).not_to have_text("Billy light chainsaw")
    expect(page).not_to have_text("ACME Light chainsaw Variant 9001")

    click_link "All (Sorted by Quote Date)"
    expect(page).to have_link("PR#0001")
    expect(page).to have_text("2014 Heavy Bolter")
    expect(page).to have_text("Heavy Bolter 2014 model S1")
    expect(page).to have_text("light chainsaw")
    expect(page).to have_text("Billy light chainsaw")
    expect(page).not_to have_text("ACME Light chainsaw Variant 9001")
  end

  it "should be searchable" do
    visit root_path

    search_terms = ['HVB-001', 'Super Seller', 'heavy bolter', 'heavy', 'bolt*']

    search_terms.each do |search_term|
      fill_in 'search_string', with: search_term
      select 'quote', from: 'search_type'
      click_button 'Search'
      expect(page).to have_link('PR#0001')
    end
  end

end

