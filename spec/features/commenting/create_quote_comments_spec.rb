require 'rails_helper'

feature "Creating a quote comment", js: true  do
 include_context "Quote with 1 request and 1 offer"

 let(:rfq_reference) { 'PR# Q1-O1' }

 before do
   click_link "Price Quotes"
   click_link rfq_reference
   fill_in "quote_comment_body", with: "Well met"
   click_button "Comment"
 end

 scenario "Comments should show up" do
   click_link "Price Quotes"
   click_link rfq_reference
   expect(page).to have_content("Well met")
 end

end
