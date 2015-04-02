require 'rails_helper'

feature "Delivery and SI", js: true do
  include_context "Order quote with 1 request and 1 offer"

  context "Filling up the DR reference on an order" do
    before do
      visit root_path
      click_link "Client Orders"
      click_link "Set Delivery"
      fill_in "DR #", with: 'DR#1-1'
      click_button "Update Supplier order"
    end

    it "adds an entry to the Delivery and Invoices page" do
      visit deliveries_and_invoices_path
      expect(page).to have_text("DR#1-1")
      expect(page).to have_link("PR# Q1-O1")
      expect(page).to have_link("PO#2")
    end
  end

  context "Filling up the SI reference on an order" do
    before do
      visit root_path
      click_link "Client Orders"
      click_link "Set Delivery"
      fill_in "SI #", with: 'SI#1-1'
      click_button "Update Supplier order"
    end

    it "adds an entry to the Delivery and Invoices page" do

      visit deliveries_and_invoices_path
      expect(page).to have_text("SI#1-1")
      expect(page).to have_link("PR# Q1-O1")
      expect(page).to have_link("PO#2")
    end
  end


end

