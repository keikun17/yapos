require 'rails_helper'

RSpec.describe "ProductFields", :type => :request do
  describe "GET /product_fields" do
    it "works! (now write some real specs)" do
      get product_fields_path
      expect(response.status).to be(200)
    end
  end
end
