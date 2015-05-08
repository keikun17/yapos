require 'rails_helper'

feature "Payments", js: true do
  include_context "Paid order with 1 request and 1 offer"
  let(:invoice_reference) { "Invoice#001" }
  let(:payment_references) { ["Check#1001", "Check#1002"] }
  let(:quote_reference) { "PR# Q1-O1" }
  let(:order_reference) { "PO#2" }

  scenario "creation" do
    payment_references.each do |payment_reference|
      click_link "Invoices"
      click_link invoice_reference
      click_link(payment_reference)

      expect(page).to have_text(payment_reference)
      expect(page).to have_link(invoice_reference)
      expect(page).to have_link(quote_reference)
      expect(page).to have_link(order_reference)
    end


  end

end
