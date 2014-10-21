require "rails_helper"

RSpec.describe VendorItemsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/vendor_items").to route_to("vendor_items#index")
    end

    it "routes to #new" do
      expect(:get => "/vendor_items/new").to route_to("vendor_items#new")
    end

    it "routes to #show" do
      expect(:get => "/vendor_items/1").to route_to("vendor_items#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/vendor_items/1/edit").to route_to("vendor_items#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/vendor_items").to route_to("vendor_items#create")
    end

    it "routes to #update" do
      expect(:put => "/vendor_items/1").to route_to("vendor_items#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/vendor_items/1").to route_to("vendor_items#destroy", :id => "1")
    end

  end
end
