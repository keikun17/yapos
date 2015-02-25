RSpec.shared_context "Hardware suppliers and clients exist" do
  before do
    Supplier.where(name: "Super Seller").first || create(:supplier, name: "Super Seller")
    Supplier.where(name: "ACME").first || create(:supplier, name: "ACME")
    Client.where(name: "Sybil").first || create(:client, name: "Sybil", abbrev: "SBL")
    Client.where(name: "Blue Buyers").first || create(:client, name: "Blue Buyers", abbrev: "BBuy")

    # Products
    Product.where(name: 'Bolter').first || create(:bolter)
    Product.where(name: 'Chainsaw').first || create(:chainsaw)
  end
end
