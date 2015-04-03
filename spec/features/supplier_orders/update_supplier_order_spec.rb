require 'rails_helper'

feature "Updating Supplier", js: true do
  context "A Supplier Order that was updated" do
    include_context "Order quote with 1 request and 1 offer"

    before do
      visit root_path

      ###########################
      #  SETTING SUPPLIER ORDERS
      ###########################

      # Second Client PO for Q1-O1
      click_link "Client Orders"
      click_link "Supplier PO required"
      click_link "PO#2"
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
      click_link "PO#2"
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
      handle_window = window_opened_by { click_link "Print Supplier PO# SUPPLIER PO#1-revised", match: :first }
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


    it "can be reedited from the supplier purchase form" do
      click_link "Supplier Orders"
      expect(page).not_to have_link("SUPPLIER PO#1-orig")

      click_link("SUPPLIER PO#1-revised")
      click_link("Edit", match: :first)

      # Form
      within(page.all(".supplier-order-item")[0]) do
        find(:css, "textarea[name^='supplier_purchase[supplier_orders_attributes]'][name$='[actual_specs]']").set("Personal Chainsaw Superior Edition")
        find(:css, "select[name^='supplier_purchase[supplier_orders_attributes]'][name$='[buying_currency]']").select("JPY")
        find(:css, "input[name^='supplier_purchase[supplier_orders_attributes]'][name$='[buying_price]']").set("300.36")
      end
      click_button "Update Supplier purchase"

      # Navigate back to te supplier orders page
      click_link "Supplier Orders"
      click_link("SUPPLIER PO#1-revised")
      handle_window = window_opened_by { click_link "Print Supplier PO# SUPPLIER PO#1-revised", match: :first }
      within_window(handle_window) do

        #header
        expect(page).to have_text("SUPPLIER PO#1")
        expect(page).to have_text("Sybil")

        expect(page).to have_text("5.0 piece")
        expect(page).to have_text("Personal Chainsaw Superior Edition")
        expect(page).to have_text("JPY300.36/piece")

        # Total Price
        expect(page).to have_text("JPY1,501.80")
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
