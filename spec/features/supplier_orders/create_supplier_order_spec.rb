require 'rails_helper'

feature "Supplier Order Creation" do



  context "Order within Same RFQ", js: true do
    include_context "Quote with 2 request and 3 offers"

    context "Same Supplier PO number" do
      before do
        visit root_path
        click_link "PR#0001"
        click_link "Edit", match: :first


        # Offer #1 for Request #1
        within(page.all(".offer-line")[0]) do
          fill_in "Client PO#", with: "PO#1"
        end

        # Offer #2 for Request #2
        within(page.all(".offer-line")[2]) do
          fill_in "Client PO#", with: "PO#1"
        end

        click_button "Update Quote"

        expect(Order.count).to eq(1)
        expect(Order.where(reference: 'PO#1')).not_to be_nil

        click_link "Client Orders"

        expect(page).to have_link("PO#1")

        click_link "Supplier PO required"
        expect(page).to have_link("PO#1")

        click_link "PO#1"
        click_link "Edit", match: :first

        within(page.all(".offer-line")[0]) do
          find(:css, "textarea[name^='order[offers_attributes]'][name$='[actual_specs]']").set("HVY BLTR 2014S1")
          find(:css, "input[name^='order[offers_attributes]'][name$='[reference]']").set("SUPPLIER PO#1")
        end

        within(page.all(".offer-line")[1]) do
          find(:css, "textarea[name^='order[offers_attributes]'][name$='[actual_specs]']").set("LIGHT CSAW v9001")
          find(:css, "input[name^='order[offers_attributes]'][name$='[reference]']").set("SUPPLIER PO#1")
        end

        click_button "Update Order"

        # Make sure that the PO is removed from the 'Supplier PO required' page
      end

      it "should be printable" do
        click_link "Client Orders"
        click_link "Supplier PO required"
        expect(page).to_not have_link("PO#1")
        click_link "Supplier Orders"

        expect(page).to have_link("SUPPLIER PO#1")
        handle_window = window_opened_by { click_link "SUPPLIER PO#1" }

        within_window(handle_window) do
          #header
          expect(page).to have_text("SUPPLIER PO#1")
          expect(page).to have_text("Blue Buyers")

          # Request 1 Offer 1
          expect(page).to have_text("100.0 meter")
          expect(page).to have_text("HVY BLTR 2014S1")
          expect(page).to have_text("US$90.00/meter")
          expect(page).to have_text("US$9,000.00")

          # Request 2 Offer2
          expect(page).to have_text("200.0 meter")
          expect(page).to have_text("LIGHT CSAW v9001")
          expect(page).to have_text("PHP12,345,678,999.88/meter")
          expect(page).to have_text("PHP2,469,135,799,976.00")

          # Total Price
          # TODO , FIXME : Assert that US$ total and PHP total are separate
          expect(page).to have_text("2,469,135,799,976.00")
        end
      end

      it "is searchable" do
        visit root_path

        search_terms = ["SUPPLIER PO#1", 'HVY*', 'LIGHT', '*', 'Blue Buyers']

        search_terms.each do |search_term|
          fill_in 'search_string', with: search_term
          select 'supplier order', from: 'search_type'
          click_button 'Search'
          expect(page).to have_link('SUPPLIER PO#1')
        end
      end
    end


    scenario "Different Supplier PO#" do
      visit root_path
      click_link "PR#0001"
      click_link "Edit", match: :first


      # Offer #1 for Request #1
      within(page.all(".offer-line")[0]) do
        fill_in "Client PO#", with: "PO#1"
      end

      # Offer #2 for Request #2
      within(page.all(".offer-line")[2]) do
        fill_in "Client PO#", with: "PO#1"
      end

      click_button "Update Quote"

      expect(Order.count).to eq(1)
      expect(Order.where(reference: 'PO#1')).not_to be_nil

      click_link "Client Orders"
      expect(page).to have_link("PO#1")

      click_link "Supplier PO required"
      expect(page).to have_link("PO#1")

      click_link "PO#1"
      click_link "Edit", match: :first

      within(page.all(".offer-line")[0]) do
        find(:css, "textarea[name^='order[offers_attributes]'][name$='[actual_specs]']").set("HVY BLTR 2014S1")
        find(:css, "input[name^='order[offers_attributes]'][name$='[reference]']").set("SUPPLIER PO#1")
      end

      within(page.all(".offer-line")[1]) do
        find(:css, "textarea[name^='order[offers_attributes]'][name$='[actual_specs]']").set("LIGHT CSAW v9001")
        find(:css, "input[name^='order[offers_attributes]'][name$='[reference]']").set("SUPPLIER PO#2")
      end

      click_button "Update Order"

      click_link "Supplier Orders"

      expect(page).to have_link("SUPPLIER PO#1")
      expect(page).to have_link("SUPPLIER PO#2")


      supplier_po_1_window = window_opened_by { click_link "SUPPLIER PO#1" }
      supplier_po_2_window = window_opened_by { click_link "SUPPLIER PO#2" }

      within_window(supplier_po_1_window) do
        #header
        expect(page).to have_text("SUPPLIER PO#1")
        expect(page).to have_text("Blue Buyers")

        # Request 1 Offer 1
        expect(page).to have_text("100.0 meter")
        expect(page).to have_text("HVY BLTR 2014S1")
        expect(page).to have_text("US$90.00/meter")
        expect(page).to have_text("US$9,000.00")


      end

      within_window(supplier_po_2_window) do
        #header
        expect(page).to have_text("SUPPLIER PO#2")
        expect(page).to have_text("Blue Buyers")

        # Request 2 Offer2
        expect(page).to have_text("200.0 meter")
        expect(page).to have_text("LIGHT CSAW v9001")
        expect(page).to have_text("PHP12,345,678,999.88/meter")
        expect(page).to have_text("PHP2,469,135,799,976.00")
      end
    end

    scenario "Client is hidden from printable view"
  end

  context "Different RFQ", js: true do
    include_context "Quote with 1 request and 2 offers"
    include_context "Quote with 1 request and 1 offer"

    scenario "Same Supplier PO, different Client PO and RFQ" do
      visit root_path

      ###########################
      #  SETTING CLIENT ORDERS
      ###########################

      # RFQ 1
      click_link "Price Quotes"
      click_link "PR# Q1-O2"
      click_link "Edit", match: :first

      within(page.all(".offer-line")[0]) do
        fill_in "Client PO#", with: "PO#1"
      end

      click_button "Update Quote"

      # RFQ 2
      click_link "Price Quotes"
      click_link "PR# Q1-O1"
      click_link "Edit", match: :first

      # Offer #1 for Request #1
      within(page.all(".offer-line")[0]) do
        fill_in "Client PO#", with: "PO#2"
      end

      click_button "Update Quote"

      ###########################
      #  SETTING SUPPLIER ORDERS
      ###########################

      # First Client PO for Q1-O2
      click_link "Client Orders"
      click_link "Supplier PO required"
      click_link "PO#1"
      click_link "Edit", match: :first

      within(page.all(".offer-line")[0]) do
        find(:css, "textarea[name^='order[offers_attributes]'][name$='[actual_specs]']").set("Billy light chainsaw")
        find(:css, "input[name^='order[offers_attributes]'][name$='[reference]']").set("SUPPLIER PO#1")
      end
      click_button "Update Order"

      # Second Client PO for Q1-O1
      click_link "Client Orders"
      click_link "Supplier PO required"
      click_link "PO#2"
      click_link "Edit", match: :first

      within(page.all(".offer-line")[0]) do
        find(:css, "textarea[name^='order[offers_attributes]'][name$='[actual_specs]']").set("Personal Chainsaw")
        find(:css, "input[name^='order[offers_attributes]'][name$='[reference]']").set("SUPPLIER PO#1")
      end
      click_button "Update Order"


      ###########################
      # PRINTABLE SUPPLIER ORDER
      ###########################

      click_link "Supplier Orders"
      expect(page).to have_link("SUPPLIER PO#1")

      handle_window = window_opened_by { click_link "SUPPLIER PO#1", match: :first }

      within_window(handle_window) do

        #header
        expect(page).to have_text("SUPPLIER PO#1")
        expect(page).to have_text("Sybil")

        # Line1
        expect(page).to have_text("2.0 piece")
        expect(page).to have_text("Billy light chainsaw")
        expect(page).to have_text("US$50.00/piece")
        expect(page).to have_text("US$100.00")

        # Line2
        expect(page).to have_text("5.0 piece")
        expect(page).to have_text("Personal Chainsaw")
        expect(page).to have_text("US$1,234,567,899.88/piece")
        expect(page).to have_text("US$6,172,839,499.40")

        # Total Price
        expect(page).to have_text("US$6,172,839,599.40")
      end

    end

    scenario "Service PO should not require supplier PO" do
      visit root_path

      ###########################
      #  SETTING CLIENT ORDERS
      ###########################

      # RFQ 1 (SERVICE)
      click_link "Price Quotes"
      click_link "PR# Q1-O2"
      click_link "Edit", match: :first

      within(page.all(".offer-line")[0]) do
        check "Service"
        fill_in "Client PO#", with: "SERVICE PO#1"
      end

      click_button "Update Quote"

      # RFQ 2
      click_link "Price Quotes"
      click_link "PR# Q1-O1"
      click_link "Edit", match: :first

      # Offer #1 for Request #1
      within(page.all(".offer-line")[0]) do
        fill_in "Client PO#", with: "Supply PO#2"
      end

      click_button "Update Quote"

      ###########################
      # Assertions
      ###########################
      click_link "Client Orders"
      click_link "Supplier PO required"

      expect(page).not_to have_text("Service PO#1")
      expect(page).to have_text("Supply PO#2")

    end

  end

end

