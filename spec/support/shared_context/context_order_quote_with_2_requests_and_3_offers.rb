RSpec.shared_context "Order quote with 2 requests and 3 offers", :a => :b do
  include_context "Quote with 2 request and 3 offers"

  background do
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
  end

end
