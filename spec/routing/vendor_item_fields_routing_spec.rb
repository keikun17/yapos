require "rails_helper"

RSpec.describe VendorItemFieldsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/vendor_item_fields").to route_to("vendor_item_fields#index")
    end

    it "routes to #new" do
      expect(:get => "/vendor_item_fields/new").to route_to("vendor_item_fields#new")
    end

    it "routes to #show" do
      expect(:get => "/vendor_item_fields/1").to route_to("vendor_item_fields#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/vendor_item_fields/1/edit").to route_to("vendor_item_fields#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/vendor_item_fields").to route_to("vendor_item_fields#create")
    end

    it "routes to #update" do
      expect(:put => "/vendor_item_fields/1").to route_to("vendor_item_fields#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/vendor_item_fields/1").to route_to("vendor_item_fields#destroy", :id => "1")
    end

  end
end
