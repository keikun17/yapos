RSpec.shared_context "Supplier ordered quote with 2 requests and 3 offers", a: :b do
  include_context "Order quote with 2 requests and 3 offers"

  background do
    click_link "Client Orders"

    expect(page).to have_link("PO#1")

    click_link "Supplier PO required"
    expect(page).to have_link("PO#1")

    click_link "PO#1"
    click_link "Edit", match: :first

    within(page.all(".offer-line")[0]) do
      find(:css, "textarea[name^='order[offers_attributes]'][name$='[actual_specs]']").set("HVY BLTR 2014S1")
      find(:css, "input[name^='order[offers_attributes]'][name$='[reference]']").set("SUPPLIER PO#1")
    end

    within(page.all(".offer-line")[1]) do
      find(:css, "textarea[name^='order[offers_attributes]'][name$='[actual_specs]']").set("LIGHT CSAW v9001")
      find(:css, "input[name^='order[offers_attributes]'][name$='[reference]']").set("SUPPLIER PO#1")
    end

    click_button "Update Order"
  end
end
