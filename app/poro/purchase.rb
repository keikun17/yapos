class Purchase
  include ActionView::Helpers::NumberHelper

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

  def self.total_profit
    Offer.purchased.sum(:total_selling_price) - Offer.purchased.sum(:total_buying_price)
  end

  def self.display_total_profit
    helper.number_to_currency(total_profit, unit: Currency::LOCAL_CURRENCY)
  end

  private

  def self.helper
    Helper.instance
  end

  class Helper
    include Singleton
    include ActionView::Helpers::NumberHelper
  end

  def self.fetch_or_create_from_quote(quote)
    quote.offers.each do |offer|
      fetch_or_create_from_offer(offer)
    end

    quote
  end

  def self.fetch_or_create_from_offer(offer)
    if !offer.order_reference.blank?
      Order.find_or_create_by_reference(offer.order_reference)
      order.supplier_purchases.find_or_create_by_reference(offer.supplier_order.reference)
      offer.create_supplier_order
    end
  end

end
