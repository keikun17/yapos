RSpec.shared_context "Quote with 2 request and 3 offers", :a => :b do
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
    create(:supplier, name: "Super Seller")
    create(:supplier, name: "ACME")
    create(:client, name: "Blue Buyers", abbrev: "BBuy")

    # Products
    create(:bolter)
    create(:chainsaw)

    logged_as_default_user


    expect(Quote.count).to eq(0)

    visit root_path

    click_link "Price Quotes"
    click_link "New Quote"

    fill_in "Client PR#", with: "PR#0001"
    select "Blue Buyers", from: "Client"

    fill_in "Signatory", with: "Jack"
    fill_in "Signatory position", with: "Sparrow"

    within(page.all(".request-line")[0]) do
      fill_in 'Item#', with: '1'
      fill_in 'Quantity', with: '100'
      fill_in 'Unit', with: 'meter'

      fill_in 'Request Specs', with: 'heavy bolter'
      fill_in 'Item/Material Code', with: 'HVB-001'
    end

    within(page.all(".offer-controls")[0]) do
      click_link "Offer"
    end

    # Offer #1 for Request #1
    within(page.all(".offer-line")[0]) do
      select "Super Seller", from: 'Brand'
      fill_in "Specs/Description", with: "2014 Heavy Bolter"
      fill_in "Actual Specs", with: "Heavy Bolter 2014 model S1"

      # Vendor Item
      click_link "Input Actual Specs"
      select "Bolter", from: 'Product'

      fill_in "Weight", with: '1000'
      fill_in "Year", with: '1999'
      fill_in "Model", with: '1000'

      click_link "submit"

      find(:css, "select[name^='quote[requests_attributes]'][name$='[buying_currency]']").set("US$")
      find(:css, "select[name^='quote[requests_attributes]'][name$='[currency]']").set("US$")
      fill_in "VAT Status", with: "VAT EX"
      fill_in "Supplier Price", with: 90
      fill_in "Our Price", with: 100
      fill_in "Price Basis", with: "FOB JAPAN"

      fill_in "Terms", with: "30 days"
      fill_in "Delivery", with: "60 days"
      fill_in "Warranty", with: "1 year"
      fill_in "Notes", with: "Comes with free drillbits"
    end


    click_link "Request Item"

    # within(".request-line:eq(2)") do
    within(page.all(".request-line")[1]) do
      fill_in 'Item#', with: '2'
      fill_in 'Quantity', with: '200'
      fill_in 'Unit', with: 'meter'
      fill_in 'Request Specs', with: 'lighth chainsaw'
      fill_in 'Item/Material Code', with: 'LCS-001'
    end

    within(page.all(".offer-controls")[1]) do
      click_link "Offer"
    end

    # First offer for Request #2
    within(page.all(".offer-line")[1]) do
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

      find(:css, "select[name^='quote[requests_attributes]'][name$='[buying_currency]']").set("US$")
      find(:css, "select[name^='quote[requests_attributes]'][name$='[currency]']").set("US$")
      fill_in "VAT Status", with: "VAT EX"
      fill_in "Supplier Price", with: 50
      fill_in "Our Price", with: 60
      fill_in "Price Basis", with: "FOB JAPAN"

      fill_in "Terms", with: "30 days"
      fill_in "Delivery", with: "60 days"
      fill_in "Warranty", with: "1 year"
      fill_in "Notes", with: "Batteries not included"
    end

    within(page.all(".offer-controls")[1]) do
      click_link "Offer"
    end

    # Second Offer for Request #2
    within(page.all(".offer-line")[2]) do
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

    expect(VendorItem.count).to eq(3)
  end

end
