require 'rails_helper'

feature "Print quotes", js: true do

  context "2 different suppliers in the quote" do
    include_context "Quote with 2 request and 3 offers"

    before do
      visit root_path
      click_link "Price Quotes"
      click_link "PR#0001"
    end

    scenario "Print all offers" do

      handle_window = window_opened_by { click_link "Print" }

      within_window(handle_window) do
        expect(page).to have_text("Blue Buyers")
        expect(page).to have_text("Jack")
        expect(page).to have_text("Sparrow")

        # request 1
        expect(page).to have_text("100.0")
        expect(page).to have_text("meter")
        expect(page).to have_text("heavy bolter")

        # binding.pry
        # request 1 offer 1
        expect(page).to have_text("Super Seller")
        expect(page).to have_text("2014 Heavy Bolter")
        expect(page).not_to have_text("Heavy Bolter 2014 model S1")
        expect(page).to have_text("US$100.00/meter (VAT EX FOB JAPAN")
        expect(page).to have_text("US$10,000.00 (VAT EX FOB JAPAN)")

        # request 2
        expect(page).to have_text("200.0")
        expect(page).to have_text("meter")
        expect(page).to have_text("lighth chainsaw")

        # request 2 offer 1
        expect(page).to have_text("Super Seller")
        expect(page).to have_text("light chainsaw")
        expect(page).not_to have_text("Billy light chainsaw")
        expect(page).to have_text("US$60.00/meter (VAT EX FOB JAPAN")
        expect(page).to have_text("US$12,000.00 (VAT EX FOB JAPAN)")

        # request 2 offer 1
        expect(page).to have_text("ACME")
        expect(page).to have_text("light chainsaw")
        expect(page).not_to have_text("ACME Light chainsaw Variant 9001")
        expect(page).to have_text("PHP5,000.00/meter (VAT INC FOB PIER)")
        expect(page).to have_text("PHP1,000,000.00 (VAT INC FOB PIER)")
      end
    end

    scenario "Print just Super Seller offers" do
      handle_window = window_opened_by { click_link "Print only Super Seller offers" }

      within_window(handle_window) do
        expect(page).to have_text("Blue Buyers")
        expect(page).to have_text("Jack")
        expect(page).to have_text("Sparrow")

        # request 1
        expect(page).to have_text("100.0")
        expect(page).to have_text("meter")
        expect(page).to have_text("heavy bolter")

        # binding.pry
        # request 1 offer 1
        expect(page).to have_text("Super Seller")
        expect(page).to have_text("2014 Heavy Bolter")
        expect(page).not_to have_text("Heavy Bolter 2014 model S1")
        expect(page).to have_text("US$100.00/meter (VAT EX FOB JAPAN")
        expect(page).to have_text("US$10,000.00 (VAT EX FOB JAPAN)")

        # request 2
        expect(page).to have_text("200.0")
        expect(page).to have_text("meter")
        expect(page).to have_text("lighth chainsaw")

        # request 2 offer 1
        expect(page).to have_text("Super Seller")
        expect(page).to have_text("light chainsaw")
        expect(page).not_to have_text("Billy light chainsaw")
        expect(page).to have_text("US$60.00/meter (VAT EX FOB JAPAN")
        expect(page).to have_text("US$12,000.00 (VAT EX FOB JAPAN)")

        # request 2 offer 1
        expect(page).not_to have_text("ACME")
        expect(page).not_to have_text("ACME Light chainsaw Variant 9001")
        expect(page).not_to have_text("PHP5,000.00/meter (VAT INC FOB PIER)")
        expect(page).not_to have_text("PHP1,000,000.00 (VAT INC FOB PIER)")
      end
    end

  end


  context "2 different suppliers in the quote, one supplier is hidden" do
    include_context "Quote with 2 request and 3 offers"

    let(:rfq_reference) { "PR#0001" }
    before do
      click_link "Price Quotes"
      click_link rfq_reference
      click_link "Edit", match: :first

      # Hide ACME
      within(page.all(".offer-line")[2]) do
        find(:css, "input[name^='quote[requests_attributes]'][name$='[hide_supplier_in_print]']").set(true)
      end

      click_button "Update Quote"
    end

    scenario "Print all offers" do
      click_link "Price Quotes"
      click_link rfq_reference

      handle_window = window_opened_by { click_link "Print" }
      within_window(handle_window) do
        expect(page).to_not have_text("ACME")
        expect(page).to have_text("Super Seller")
      end

    end

    scenario "Print supplier specific" do
      click_link "Price Quotes"
      click_link rfq_reference

      handle_window = window_opened_by { click_link "Print only ACME offers" }
      within_window(handle_window) do
        expect(page).to_not have_text("BRAND")
        expect(page).to_not have_text("ACME")
      end
    end

  end


end

