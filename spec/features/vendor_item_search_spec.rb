require 'rails_helper'

feature "Search vendor items containing given property" do
  include_context "AR Belt Product with 3 Vendor Items"

  before do
    logged_as_default_user
  end

  it "returns all vendor items matching the given spec", js: true do
    visit search_vendor_item_path

    select "Contains", from: 'Filter'
    select "Abrasive Resistant Conveyor Belt", from: 'Product'

    fill_in "EP", with: '100'
    # fill_in "Top Cover", with: '5'
    # fill_in "Bottom Cover", with: '3'
    click_button "Search Items"

    expect(page).to have_content('Abrasive Resistant Conveyor Belt - 100,5,3')
    expect(page).to have_content('Abrasive Resistant Conveyor Belt - 1000,100,5,3')
    expect(page).to have_content('Abrasive Resistant Conveyor Belt - 100,5,2')
    expect(page).not_to have_content('Abrasive Resistant Conveyor Belt - 200,6,2')
  end

  it "returns all vendor items matching the given spec", js: true do
    visit search_vendor_item_path

    select "Exact", from: 'Filter'
    select "Abrasive Resistant Conveyor Belt", from: 'Product'

    fill_in "EP", with: '100'
    fill_in "Top Cover", with: '5'
    fill_in "Bottom Cover", with: '3'
    click_button "Search Items"

    expect(page).to have_content('Abrasive Resistant Conveyor Belt - 100,5,3')
    expect(page).not_to have_content('Abrasive Resistant Conveyor Belt - 1000,100,5,3')

    expect(page).not_to have_content('Abrasive Resistant Conveyor Belt - 100,5,2')
    expect(page).not_to have_content('Abrasive Resistant Conveyor Belt - 200,6,2')
  end

end
