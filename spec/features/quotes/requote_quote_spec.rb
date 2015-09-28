require 'rails_helper'

feature "Requoting Quote", js: true do

  context "Requote Quote" do
    include_context "Quote with 1 request and 1 offer"
    let(:quote_reference) { "PR# Q1-O1"}
    let(:requote_reference) { "#{quote_reference}-requote"}
    let(:client_name) { "SBL"}

    before do
      visit root_path
      click_link "Price Quotes"
      click_link(quote_reference)

      click_link "Requote", match: :first
    end

    scenario do
      expect(Request.count).to eq(2)
      expect(Offer.count).to eq(2)

      click_link "Price Quotes"
      expect(page).to have_link(quote_reference)

      click_link requote_reference

      expect(page).to have_text(client_name)
      expect(page).to have_text("Personal Chainsaw")
      expect(page).to have_text("PRS-LCS-CSAW")
      expect(page).to have_text("Chainsaw (handcarry edition)")

      expect(page).to have_text("History RFQ: #{quote_reference}")
      expect(page).to_not have_text("History client order:")
      expect(page).to_not have_text("History supplier purchase:")
    end
  end

  context "Requote Qutote with PO and Supplier PO" do
    include_context "Supplier ordered quote with 2 requests and 3 offers"

    let(:quote_reference) { "PR#0001"}
    let(:po_reference) { "PO#1"}
    let(:requote_reference) { "PR#0001-requote"}
    let(:client_name) { "BBuy" }
    let(:po_reference) { "PO#1" }
    let(:supplier_po_reference) { "SUPPLIER PO#1" }

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
      expect(page).to have_link("Enter PO#")
      expect(page).to have_text(client_name)
      expect(page).to have_text("heavy bolter")
      expect(page).to have_text("2014 Heavy Bolter")
      expect(page).to have_text("lighth chainsaw")
      expect(page).to have_text("Billy light chainsaw")
      expect(page).to have_text("ACME Light chainsaw Variant 9001")
      expect(page).to have_text("History RFQ: #{quote_reference}")
      expect(page).to have_text("History client order: #{po_reference} ")
      expect(page).to have_text("History supplier purchase: #{supplier_po_reference}")
    end

  end
end
