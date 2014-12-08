require 'rails_helper'

feature "Search vendor items containing given property" do
  include_context "Quote with 2 request and 3 offers"

  it "returns all vendor items that contains values in the search query", js: true do
    visit search_vendor_item_path

    select "Chainsaw", from: 'Product'
    select "Contains", from: 'Filter'

    fill_in "Weight", with: '5'
    fill_in "Year", with: '2014'

    click_button "Search Items"

    expect(page).to have_content('Chainsaw - 5kg,2014,Ultra')
    expect(page).to have_content('Chainsaw - 5kg,2014')
    expect(page).not_to have_content('Bolter - 1000kg,1999,1000')
  end

  it "returns all vendor items that exactly match the search query", js: true do
    visit search_vendor_item_path

    select "Chainsaw", from: 'Product'
    select "Contains", from: 'Filter'

    fill_in "Weight", with: '5'
    fill_in "Year", with: '2014'
    click_button "Search Items"

    expect(page).to have_content('Chainsaw - 5kg,2014')
    expect(page).not_to have_content('Chainsaw - 5kg,2014,Ultra')
    expect(page).not_to have_content('Bolter - 1000kg,1999,1000')
  end

end
