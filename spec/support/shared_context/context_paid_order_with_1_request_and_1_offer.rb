RSpec.shared_context "Paid order with 1 request and 1 offer", :a => :b do
  include_context "Order quote with 1 request and 1 offer"

  before do
    click_link "Client Orders"
    click_link "PO#2"

    click_link "Set SI/DR details for all offers in this order"
    fill_in "SI Reference", with: "Invoice#001"
    click_button "Update all items for this order"

    click_link "Invoice#001"
    click_link "Edit"

    fill_in "Actual Invoice Total Amount", with: "12345678987.67"

    within(page.all(".payment-line")[0]) do
      find(:css, "input[name^='invoice[payments_attributes]'][name$='[reference]']").set("Check#1001")
    end

    click_link "Add Payment"

    within(page.all(".payment-line")[1]) do
      find(:css, "input[name^='invoice[payments_attributes]'][name$='[reference]']").set("Check#1002")
    end

    click_button "Update Invoice"
  end
end

