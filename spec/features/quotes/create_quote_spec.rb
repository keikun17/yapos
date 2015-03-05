require 'rails_helper'

feature "Quotes Creation", js: true do
  include_context "Quote with 2 request and 3 offers"

  it "updates the records", js: true do
    expect(Quote.count).to eq(1)
    expect(Request.count).to eq(2)
    expect(Offer.count).to eq(3)
    expect(VendorItem.count).to eq(3)
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

