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

  def unit
    content_tag :i do
      ["Pieces", "Rolls", "Meter"].sample
    end
  end

  def quantity
    content_tag :i do
      ["10", "20", "15"].sample
    end
  end
end
