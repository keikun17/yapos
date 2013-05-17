class SupplierPurchaseDecorator < Decorator
  
  #FIXME : ugly
  def supplier_name
    if !supplier_orders.empty?
      supplier_orders.first.supplier_name
    end
  end

  #FIXME : ugly
  def client
    if !supplier_orders.empty?
      @client ||= supplier_orders.first.offer.client
    end
  end

  def client_name
    client.name if client
  end

  def offer
    @offer ||= OfferDecorator.new(__getobj__.offer)
  end

  def supplier_orders
    @supplier_orders ||= SupplierOrderDecorator.decorate_collection(__getobj__.supplier_orders)
  end
end
