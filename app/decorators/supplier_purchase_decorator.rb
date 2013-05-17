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

  # FIXME : make me deal with non local currency amounts
  def display_total_amount
    @display_total_amount ||= if !supplier_orders.empty?
        number_to_currency(supplier_orders.map(&:offer_total_buying_price).sum || 0, unit: Currency::LOCAL_CURRENCY) + total_amount_suffix
      else
        number_to_currency(0, unit: Currency::LOCAL_CURRENCY) + total_amount_suffix
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

  private

  def total_amount_suffix
    @total_amount_suffix ||= if supplier_orders.first
      str = [supplier_orders.first.offer_price_vat_status, self.supplier_orders.first.offer_price_basis].compact.join(" ")
      if !str.blank?
        str ="(#{str})"
      end
      str
    end
  end
end
