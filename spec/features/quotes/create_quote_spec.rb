require 'rails_helper'

feature "Quotes Creation", js: true do
  include_context "Quote with 2 request and 3 offers"

  it "updates the records", js: true do
    expect(Quote.count).to eq(1)
    expect(Request.count).to eq(2)
    expect(Offer.count).to eq(3)
    expect(VendorItem.count).to eq(3)
  end

  it "should be searchable"

end

