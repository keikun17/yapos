class RequestDecorator < Decorator
  def offered_brands
    self.offers.map(&:supplier_name).join(',')
  end
end
