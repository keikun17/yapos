class Purchase
  def self.create_or_append(source)
    case source.class.to_s
    when "Quote"
      fetch_or_create_from_quote(source)
    when "Offer"
      fetch_or_create_from_offer(source)
    else
      raise("not implement for #{source.class}")
    end
  end

  private

  def self.fetch_or_create_from_quote(quote)
    quote.offers.each do |offer|
      fetch_or_create_from_offer(offer)
    end

    quote
  end

  def self.fetch_or_create_from_offer(offer)
    Order.find_or_create_by_reference(offer.order_reference)
    offer
  end

end
