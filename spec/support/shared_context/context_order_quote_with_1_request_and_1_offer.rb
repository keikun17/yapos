RSpec.shared_context "Order quote with 1 request and 1 offer", :a => :b do
  include_context "Quote with 1 request and 1 offer"

  before do
    click_link "Price Quotes"
    click_link "PR# Q1-O1"
    click_link "Edit", match: :first

    within(page.all(".offer-line")[0]) do
      # TODO : change this to po reference to something more specific for the
      # pre-requiside context 'Quote with 1 request and 1 offer'
      fill_in "Client PO#", with: "PO#2"
    end

    click_button "Update Quote"
  end
end
