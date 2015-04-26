RSpec.shared_context "Supplier ordered quote with 1 request and 1 offer", :a => :b do
  include_context "Order quote with 1 request and 1 offer"

  background do
    click_link "Client Orders"
    click_link "Supplier PO required"
    click_link "PO#2"

    click_link "Edit", match: :first

    within(page.all(".offer-line")[0]) do
      find(:css, "textarea[name^='order[offers_attributes]'][name$='[actual_specs]']").set("Handchainsaw")
      find(:css, "input[name^='order[offers_attributes]'][name$='[reference]']").set("SupplierPO#2")
    end

    click_button "Update Order"
  end
end
