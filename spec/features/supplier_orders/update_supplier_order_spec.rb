require 'rails_helper'

feature "Updating Supplier", js: true do
  context "A Supplier Order that was updated" do
    include_context "Quote with 1 request and 1 offer"

    before do
      visit root_path

      ###########################
      #  SETTING CLIENT ORDERS
      ###########################

      # RFQ 1
      click_link "Price Quotes"
      click_link "PR# Q1-O1"
      click_link "Edit", match: :first

      # Offer #1 for Request #1
      within(page.all(".offer-line")[0]) do
        fill_in "Client PO#", with: "PO#1"
      end

      click_button "Update Quote"

      ###########################
      #  SETTING SUPPLIER ORDERS
      ###########################

      # Second Client PO for Q1-O1
      click_link "Client Orders"
      click_link "Supplier PO required"
      click_link "PO#1"
      click_link "Edit", match: :first

      within(page.all(".offer-line")[0]) do
        find(:css, "textarea[name^='order[offers_attributes]'][name$='[actual_specs]']").set("Personal Chainsaw")
        find(:css, "input[name^='order[offers_attributes]'][name$='[reference]']").set("SUPPLIER PO#1-orig")
      end

      click_button "Update Order"

      ###########################
      # DO EDIT
      ###########################
      click_link "Client Orders"
      click_link "PO#1"
      click_link "Edit", match: :first

      within(page.all(".offer-line")[0]) do
        find(:css, "textarea[name^='order[offers_attributes]'][name$='[actual_specs]']").set("Super Personal Chainsaw")
        find(:css, "input[name^='order[offers_attributes]'][name$='[reference]']").set("SUPPLIER PO#1-revised")
      end

      click_button "Update Order"

    end

    it "shows the edited specs in the print out" do
      click_link "Supplier Orders"
      expect(page).not_to have_link("SUPPLIER PO#1-orig")

      click_link("SUPPLIER PO#1-revised")
      handle_window = window_opened_by { click_link "Print SUPPLIER PO#1-revised", match: :first }
      within_window(handle_window) do

        #header
        expect(page).to have_text("SUPPLIER PO#1")
        expect(page).to have_text("Sybil")

        expect(page).to have_text("5.0 piece")
        expect(page).to have_text("Super Personal Chainsaw")
        expect(page).to have_text("US$1,234,567,899.88/piece")
        expect(page).to have_text("US$6,172,839,499.40")

        # Total Price
        expect(page).to have_text("US$6,172,839,499.40")
      end

    end

    it "Should be searchable" do
      visit root_path

      search_terms = ["SUPPLIER PO#1", 'Personal', 'Super*', '*', 'Sybil']

      search_terms.each do |search_term|
        fill_in 'search_string', with: search_term
        select 'supplier order', from: 'search_type'
        click_button 'Search'
        expect(page).to have_link('SUPPLIER PO#1-revised')
      end
    end


  end
end
