require 'rails_helper'

RSpec.describe "VendorItemFields", :type => :request do
  describe "GET /vendor_item_fields" do
    it "works! (now write some real specs)" do
      get vendor_item_fields_path
      expect(response.status).to be(200)
    end
  end
end
