class RequestDecorator < Decorator
  def offered_brands
    self.offers.map(&:supplier_name).join(',')
  end

  def offer_count
    self.offers.count
  end

  def offset_offer_count(offset)
    offer_count + offset.to_i
  end
end
