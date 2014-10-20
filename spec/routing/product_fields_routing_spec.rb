require "rails_helper"

RSpec.describe ProductFieldsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/product_fields").to route_to("product_fields#index")
    end

    it "routes to #new" do
      expect(:get => "/product_fields/new").to route_to("product_fields#new")
    end

    it "routes to #show" do
      expect(:get => "/product_fields/1").to route_to("product_fields#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/product_fields/1/edit").to route_to("product_fields#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/product_fields").to route_to("product_fields#create")
    end

    it "routes to #update" do
      expect(:put => "/product_fields/1").to route_to("product_fields#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/product_fields/1").to route_to("product_fields#destroy", :id => "1")
    end

  end
end
