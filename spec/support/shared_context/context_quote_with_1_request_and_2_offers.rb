RSpec.shared_context "Quote with 1 request and 2 offers", :a => :b do
  include_context "Hardware suppliers and clients exist"

  # before { @some_var = :some_value }
  # def shared_method
  #   "it works"
  # end
  #
  # let(:shared_let) { {'arbitrary' => 'object'} }

  # subject do
  #   'this is the shared subject'
  # end

  before do

    logged_as_default_user

    visit root_path

    click_link "Price Quotes"
    click_link "New Quote"

    fill_in "Client PR#", with: "PR# Q1-O2"
    select "Sybil", from: "Client"

    fill_in "Signatory", with: "Red"
    fill_in "Signatory position", with: "Breach"


    # within(".request-line:eq(2)") do
    within(page.all(".request-line")[0]) do
      fill_in 'Item#', with: '1'
      fill_in 'Quantity', with: '2'
      fill_in 'Unit', with: 'meter'
      fill_in 'Request Specs', with: 'lighth chainsaw'
      fill_in 'Item/Material Code', with: 'LCS-001'
    end

    within(page.all(".offer-controls")[0]) do
      click_link "Offer"
    end

    # Request 1 Offer 1
    within(page.all(".offer-line")[0]) do
      select "Super Seller", from: 'Brand'
      fill_in "Specs/Description", with: "light chainsaw"
      fill_in "Actual Specs", with: "Billy light chainsaw"

      #vendor item
      click_link "Input Actual Specs"
      select "Chainsaw", from: 'Product'

      fill_in "Weight", with: '5'
      fill_in "Year", with: '2014'
      fill_in "Model", with: 'Ultra'

      click_link "submit"

      find(:css, "select[name^='quote[requests_attributes]'][name$='[buying_currency]']").select("US$")
      find(:css, "select[name^='quote[requests_attributes]'][name$='[currency]']").select("US$")
      fill_in "VAT Status", with: "VAT EX"
      fill_in "Supplier Price", with: 50
      fill_in "Our Price", with: 60
      fill_in "Price Basis", with: "FOB JAPAN"

      fill_in "Terms", with: "30 days"
      fill_in "Delivery", with: "60 days"
      fill_in "Warranty", with: "1 year"
      fill_in "Notes", with: "Batteries not included"
    end

    within(page.all(".offer-controls")[0]) do
      click_link "Offer"
    end

    # Requeat 1, Offer 2
    within(page.all(".offer-line")[1]) do
      select "ACME", from: 'Brand'
      fill_in "Specs/Description", with: "light chainsaw"
      fill_in "Actual Specs", with: "ACME Light chainsaw Variant 9001"

      #vendor item
      click_link "Input Actual Specs"
      select "Chainsaw", from: 'Product'

      fill_in "Weight", with: '5'
      fill_in "Year", with: '2014'

      click_link "submit"

      fill_in "VAT Status", with: "VAT INC"
      fill_in "Supplier Price", with: 4300
      fill_in "Our Price", with: 5000
      fill_in "Price Basis", with: "FOB PIER"

      fill_in "Terms", with: "60 days"
      fill_in "Delivery", with: "30 days"
      fill_in "Warranty", with: "2 years"
      fill_in "Notes", with: "Includes charger"
    end

    click_button "Create Quote"
  end

end
