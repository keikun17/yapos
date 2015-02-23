require 'rails_helper'

feature "Supplier Order Creation" do

  context "Same RFQ", js: true do
    include_context "Quote with 2 request and 3 offers"

    scenario "[Quote 1 Offer 1] and [Quote 2 Offer 2] ordered" do
      visit root_path
      click_link "PR#0001"
      click_link "Edit", match: :first


      # Offer #1 for Request #1
      within(page.all(".offer-line")[0]) do
        fill_in "Client PO#", with: "PO#1"
      end

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
    end


    scenario "[Quote 1 Offer 1] and [Quote 2 Offer 2] in one PO and [Quote 2 Offer 2] in another"
  end

  context "Different RFQ" do
    scenario "Same Supplier PO, different Client PO and RFQ" do
    end
  end


  scenario "Service PO should not require supplier PO"
end
