class PurchaseOrder

  def self.fetch
    @orders = Offer.purchased
  end

end
