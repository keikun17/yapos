require 'rails_helper'

feature "Requoting Quote", js: true do
  include_context "Order quote with 2 requests and 3 offers"

  context "Requote" do

    let(:quote_reference) { "PR#0001"}
    let(:po_reference) { "PO#1"}
    let(:requote_reference) { "PR#0001-requote"}
    let(:client_name) { "BBuy" }


    before do
      visit root_path
      click_link "Price Quotes"
      click_link(quote_reference)

      click_link "Requote", match: :first
    end

    scenario do
      click_link "Price Quotes"
      expect(page).to have_link(quote_reference)
      expect(page).to have_link(po_reference)
      expect(page).to have_link(requote_reference)

      expect(Order.count).to eq(1)
      expect(Request.count).to eq(4)
      expect(Offer.count).to eq(6)

      click_link requote_reference
      expect(page).to_not have_text(po_reference)
      expect(page).to have_text(client_name)
      expect(page).to have_text("heavy bolter")
      expect(page).to have_text("2014 Heavy Bolter")
      expect(page).to have_text("lighth chainsaw")
      expect(page).to have_text("Billy light chainsaw")
      expect(page).to have_text("ACME Light chainsaw Variant 9001")
    end

  end
end
