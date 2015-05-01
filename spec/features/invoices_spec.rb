require 'rails_helper'

feature "Sales Invoice", js: true do
  include_context "Order quote with 1 request and 1 offer"

  feature "Associating Sales invoice from the order's 'Set Delivery' modal" do
    let(:order_reference) { "PO#2" }
    let(:sales_invoice_reference_1) { "SI#1" }
    let(:sales_invoice_reference_2) { "SI#2" }

    let(:go_create_invoices) {
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
    }

    it "Creates the invoice record and associates is with the order" do
      go_create_invoices

      visit "/invoices"
      # No duplicates, only SI#1 and SI#2
      expect(Invoice.count).to eq(2)

      expect(page).to have_link(order_reference)
      expect(page).to have_link(sales_invoice_reference_1)
      expect(page).to have_link(sales_invoice_reference_2)
    end

    context "delete invoice" do
      before do
        go_create_invoices
        click_link "Client Orders"
        click_link order_reference
        click_link "Set Delivery"
        click_link "Add Invoice"

        within(page.all(".invoice-line")[1]) do
          click_link "SI" # This is the label of the deletion button
        end

        click_button "Update DR and SI record"
      end

      it "Removes the association to the invoice" do
        expect(page).to have_link(sales_invoice_reference_1)
        expect(page).not_to have_link(sales_invoice_reference_2)
        expect(Invoice.count).to eq(2) # Invoice does not get deleted. Association just removed
      end
    end

    context "An existing Sales invoice record is being assigned" do
      before do
        Invoice.create(name: 'SI#2')
        go_create_invoices
      end

      it "Uses existing invoice record and associates is with the order" do
        visit "/invoices"
        # No duplicates, only SI#1 and SI#2
        expect(Invoice.count).to eq(2)

        expect(page).to have_link(order_reference)
        expect(page).to have_link(sales_invoice_reference_1)
        expect(page).to have_link(sales_invoice_reference_2)
      end

    end
  end

  feature "Setting the Sales invoice from the 'edit order' page" do
    let(:order_reference) { "PO#2" }
    let(:sales_invoice_reference_1) { "SI#1" }
    let(:sales_invoice_reference_2) { "SI#2" }

    let(:go_create_invoices) do
      click_link "Client Orders"
      click_link order_reference
      click_link "Edit", match: :first
      click_link "Add Invoice"

      within(page.all(".invoice-line")[0]) do
        fill_in "SI Reference", with: sales_invoice_reference_1
      end

      within(page.all(".invoice-line")[1]) do
        fill_in "SI Reference", with: sales_invoice_reference_2
      end

      click_button "Update Order"
    end

    it "creates the invoice records" do
      go_create_invoices

      visit "/invoices"
      # No duplicates, only SI#1 and SI#2
      expect(Invoice.count).to eq(2)

      expect(page).to have_link(order_reference)
      expect(page).to have_link(sales_invoice_reference_1)
      expect(page).to have_link(sales_invoice_reference_2)
    end

    context "Invoice Removal" do

      before do
        go_create_invoices
        click_link "Client Orders"
        click_link order_reference
        click_link "Edit", match: :first

        within(page.all(".invoice-line")[1]) do
          click_link "SI" # This is the label of the deletion button
        end

        click_button "Update Order"
      end

      it "Removes the association to the invoice" do
        expect(page).to have_link(sales_invoice_reference_1)
        expect(page).not_to have_link(sales_invoice_reference_1)
        expect(Invoice.count).to eq(2) # Invoice does not get deleted. Association just removed
      end
    end

    context "An existing Sales invoice record is being assigned" do
       before do
         Invoice.create(name: sales_invoice_reference_1)
         go_create_invoices
       end

      it "Uses existing invoice record and associates is with the order" do
        visit "/invoices"
        # No duplicates, only SI#1 and SI#2
        expect(Invoice.count).to eq(2)

        expect(page).to have_link(order_reference)
        expect(page).to have_link(sales_invoice_reference_1)
        expect(page).to have_link(sales_invoice_reference_2)
      end

    end
  end



end
