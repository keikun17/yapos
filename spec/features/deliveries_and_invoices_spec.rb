require 'rails_helper'

feature "Delivery and SI", js: true do


  context "an order with 3 offers: 1 service, 2 supply" do
    include_context "Quote with 2 request and 3 offers"
    include_context "Quote with 1 request and 1 offer"

    background do
      visit root_path
      click_link "PR#0001"
      click_link "Edit", match: :first


      # The 2 supply offers
      within(page.all(".offer-line")[0]) do
        fill_in "Client PO#", with: "PO#1"
      end

      within(page.all(".offer-line")[2]) do
        fill_in "Client PO#", with: "PO#1"
      end

      click_button "Update Quote"


      # The 1 service offer
      click_link "Price Quotes"
      click_link "PR# Q1-O1"
      click_link "Edit", match: :first

      fill_in "Unit", with: "Assys"
      fill_in "Request Specs", with: "Assembling"
      fill_in "Specs/Description", with: "Assembling"
      fill_in "Actual Specs", with: "Assembling"
      check "Service"

      fill_in "Client PO#", with: "PO#1"

      click_button "Update Quote"
    end


    feature "Filling up the 'Mass update Si and DR' form in the order page" do
      background do
        visit root_path
        click_link "Client Orders"
        click_link "PO#1"
        click_link "Set SI/DR details for all offers in this order"
        fill_in "DR Reference", with: "DR#0101"

        click_link "Add Sales Invoice"
        within(page.all(".invoice-line")[0]) do
          fill_in "SI Reference", with: "SI#0909-a"
        end
        within(page.all(".invoice-line")[1]) do
          fill_in "SI Reference", with: "SI#0909-b"
        end

        click_button "Update all items for this order"
      end

      it "Updates the DR and SI of all the non-service offers " do

        # Only the Supplie Offers get DR
        expect(page).to have_content('DR#0101', count: 2)

        # Supply and Service Offers get SI
        expect(page).to have_content('SI#0909-a', count: 3)
        expect(page).to have_content('SI#0909-b', count: 3)
      end
    end

  end


  context "1 request and 1 offer" do
    include_context "Order quote with 1 request and 1 offer"
    feature "Filling up the DR reference on an order" do
      before do
        visit root_path
        click_link "Client Orders"
        click_link "Set Delivery / SI"
        fill_in "DR #", with: 'DR#1-1'
        click_button "Update DR and SI record"
      end

      it "adds an entry to the Delivery and Invoices page" do
        visit deliveries_and_invoices_path
        expect(page).to have_text("DR#1-1")
        expect(page).to have_link("PR# Q1-O1")
        expect(page).to have_link("PO#2")
      end
    end

    feature "Filling up the SI reference on an order" do
      before do
        visit root_path
        click_link "Client Orders"
        click_link "Set Delivery / SI"
        fill_in "SI Reference", with: 'SI#1-1'
        click_button "Update DR and SI record"
      end

      it "adds an entry to the Invoices page" do
        visit invoices_path
        expect(page).to have_text("SI#1-1")
        expect(page).to have_link("PR# Q1-O1")
        expect(page).to have_link("PO#2")
      end
    end
  end
end
