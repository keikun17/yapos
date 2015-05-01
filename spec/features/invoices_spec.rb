require 'rails_helper'

feature "Sales Invoice", js: true do
  include_context "Order quote with 1 request and 1 offer"

  feature "Associating Sales invoice from the order's 'Set Delivery' modal" do
    let(:order_reference) { "PO#2" }
    let(:sales_invoice_reference_1) { "SI#1" }
    let(:sales_invoice_reference_2) { "SI#2" }

    background do
      click_link "Client Orders"
      click_link order_reference

      click_link "Set Delivery"

      click_link "Add Invoice"

      within(page.all(".invoice-line")[0]) do
        fill_in "SI Reference", with: sales_invoice_reference_1
      end

      within(page.all(".invoice-line")[1]) do
        fill_in "SI Reference", with: sales_invoice_reference_2
      end

      click_button "Update DR and SI record"
    end

    it "Creates the invoice record and associates is with the order" do
      visit "/invoices"
      # No duplicates, only SI#1 and SI#2
      expect(Invoice.count).to eq(2)

      expect(page).to have_link(order_reference)
      expect(page).to have_link(sales_invoice_reference_1)
      expect(page).to have_link(sales_invoice_reference_2)
    end
  end

  feature "Setting the Sales invoice from the 'edit order' page" do
    pending "Invoice gets created"
  end

  context "An existing Sales invoice record is being assigned" do
    pending "Invoice does not get created and offer get associated to existing invoice"
  end


end
