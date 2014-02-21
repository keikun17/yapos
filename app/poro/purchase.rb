class Purchase
  include ActionView::Helpers::NumberHelper

  # FIXME: Violates Single responsibility?
  # 1. Finds or Creates order record that every 'purchased' offer should have
  # 2. Finds or Creates the supplier_order that every 'purchased' offer record should have
  def self.make(purchased_offers)
    purchased_offers.each do |offer|
      # 1
      Order.find_or_create_by(reference: offer.order_reference)

      # 2
      if offer.supplier_order.nil?
        offer.create_supplier_order
      end
    end
  end

  def self.total_profit
    Offer.purchased.sum(:total_selling_price) - Offer.purchased.sum(:total_buying_price)
  end

  def self.display_total_profit
    helper.number_to_currency(total_profit, unit: helper(Currency::LOCAL_CURRENCY))
  end

  private

  def self.helper
    Helper.instance
  end

  class Helper
    include Singleton
    include ActionView::Helpers::NumberHelper
  end

end
