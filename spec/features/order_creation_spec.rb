require 'rails_helper'

feature "Order Creation" do
  include_context "Quote with 2 request and 3 offers"

  scenario "Same PO for [Quote1 Offer1] and [Quote# Offer1]", js: true do
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
  end

  scenario "Different PO for [Quote1 Offer1] and [Quote# Offer1]", js: true do
    visit root_path
    click_link "PR#0001"
    click_link "Edit", match: :first


    # Offer #1 for Request #1
    within(page.all(".offer-line")[0]) do
      fill_in "Client PO#", with: "PO#1"
    end

    within(page.all(".offer-line")[2]) do
      fill_in "Client PO#", with: "PO#2"
    end

    click_button "Update Quote"

    expect(Order.count).to eq(2)
    expect(Order.where(reference: 'PO#1')).not_to be_nil
    expect(Order.where(reference: 'PO#2')).not_to be_nil
  end
end
