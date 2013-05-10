class SupplierOrderDecorator < Decorator
  def order
    @order ||= OrderDecorator.new(__getobj__.order)
  end

  def offer
    @offer ||= OfferDecorator.new(__getobj__.offer)
  end
end
