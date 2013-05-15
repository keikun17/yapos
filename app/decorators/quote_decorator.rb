class QuoteDecorator < Decorator
  def order_links
    links = OrderDecorator.decorate_collection(self.orders).collect(&:link)
    links.uniq!
    raw links.join(',')
  end

  # Maybe this belongs here instead of the model because this
  # is leaning more toward behavior than data
  def offer_details_mergable?(attr)
    details = self.offers.map(&attr).uniq
    details.count <= 1
  end

  def solo_offer_remarks
    if @solo_offer ||= self.offers.first
      return @solo_offer.remarks
    end
  end

  def solo_offer_delivery
    if @solo_offer ||= self.offers.first
      return @solo_offer.delivery
    end
  end

  def solo_offer_warranty
    if @solo_offer ||= self.offers.first
      return @solo_offer.warranty
    end
  end

  def solo_offer_terms
    if @solo_offer ||= self.offers.first
      return @solo_offer.terms
    end
  end

end
