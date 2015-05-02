require 'rails_helper'

describe DrAndSiMassUpdater, type: :poro do

  describe "update" do
     it "Only updates the DR for Supply offers, Service offers do not get DR"
     it "Sets the Delivery date for all records"
     it "Adds an SI reference to all offers"
     it "Does not remove existing SI for offers"
  end
end
