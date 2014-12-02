require 'rails_helper'

feature "Search vendor items containing given property" do
  include_context "AR Belt Product with 3 Vendor Items"

  before do
    logged_as_default_user
  end

  it "returns all vendor items matching the given spec", js: true do
    visit search_vendor_item_path
    binding.pry

    select "Abrasive Resistant Conveyor Belt", from: 'Product'

    fill_in "EP", with: '100'
    # fill_in "Top Cover", with: '5'
    # fill_in "Bottom Cover", with: '3'
    click_link "Submit"

    expect(page).to have_content('ep100x5x3')
    expect(page).to have_content('ep100x1000mmx5x3')
    expect(page).to have_content('ep100x5x2)')
    expect(page).not_to have_content('ep200x6x2')
  end

end
