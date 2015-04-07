require 'rails_helper'

feature "Order Creation" do
  context "Same RFQ" do

    context "Same PO for [Quote1 Offer1] and [Quote# Offer1]", js: true do
      include_context "Order quote with 2 requests and 3 offers"

      scenario "it creates just 1 PO record" do
        expect(Order.count).to eq(1)
        expect(Order.where(reference: 'PO#1')).not_to be_nil
        click_link "Client Orders"
        expect(page).to have_link("PO#1")
      end

      it "should be searchable"

      feature "Client Offer Pages" do
        background do
          click_link "Client Records"
          click_link "Blue Buyers"
        end

        scenario "shows the PR with linked O" do
          expect(page).to have_link "PR#0001"
          expect(page).to have_link "PO#1"
        end
      end

      feature "Supplier Offer Pages" do
        background do
          click_link "Supplier Records"
          click_link "Super Seller"
        end

        scenario "Updates the pages' tab contents" do
          # feature "Tab 1: Awaiting client Purchase" do
          click_link "Awaiting Client Purchase (Sorted by Quote Date)"
          expect(page).not_to have_link("PR#0001")
          expect(page).not_to have_link("PO#1")

          # feature "Tab 2: Client Purchased" do
          click_link "Client Purchased (Sorted by Order Date)"
          expect(page).to have_link("PR#0001")
          expect(page).to have_link("PO#1")

          # feature "Tab 3: All (Sorted by Quote Date)" do
          click_link "All (Sorted by Quote Date)"
          expect(page).to have_link("PR#0001")
          expect(page).to have_link("PO#1")
        end
      end


    end

    context "Different PO for [Quote1 Offer1] and [Quote# Offer1]", js: true do
      include_context "Quote with 2 request and 3 offers"
      before do
        visit root_path
        click_link "PR#0001"
        click_link "Edit", match: :first


        # Offer #1 for Request #1
        within(page.all(".offer-line")[0]) do
          fill_in "Client PO#", with: "PO#1-orig"
        end

        within(page.all(".offer-line")[2]) do
          fill_in "Client PO#", with: "PO#2"
        end

        click_button "Update Quote"
      end

      it "Creates two offers" do
        expect(Order.count).to eq(2)
        expect(Order.where(reference: 'PO#1-orig')).not_to be_nil
        expect(Order.where(reference: 'PO#2')).not_to be_nil

        click_link "Client Orders"
        expect(page).to have_link("PO#1-orig")
        expect(page).to have_link("PO#2")
      end

      it "makes both records searchable"

      context "Changing the reference to an order" do
        before do
          visit root_path
          click_link "PR#0001"
          click_link "Edit", match: :first

          # Offer #1 for Request #1
          within(page.all(".offer-line")[0]) do
            fill_in "Client PO#", with: "PO#1-revised"
          end

          click_button "Update Quote"
        end

        it "creates a new record" do
          expect(Order.count).to eq(3)
          expect(Order.where(reference: 'PO#1-revised')).not_to be_nil
          expect(Order.where(reference: 'PO#2')).not_to be_nil

          expect(page).not_to have_link("PO#1-orig")
          expect(page).to have_link("PO#1-revised")
          expect(page).to have_link("PO#2")
        end

        it "makes the edited record searchable" do
        end

      end

    end

  end

  context "Different RFQs" do
  end
  scenario "Marks an order in the clients page as ordered"
end

feature "Editing Order" do
  scenario "Adding items to order"
  scenario "Removing items from order"
end
