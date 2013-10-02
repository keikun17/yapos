class SupplierPurchaseDecorator < Decorator

  def supplier_name
    @supplier_name ||=  first_supplier_name
  end

  def link_to_supplier
    @supplier_link ||= first_supplier_link
  end

  def ordered_from_supplier_at(options={})
    options[:required_text] ||= 'Please Fill Up'
    if self.ordered_at.nil?
      str = content_tag :i do
        link_to options[:required_text], edit_supplier_purchase_path(decorated_object)
      end
    else
      str = self.ordered_at.to_date.to_s(:long)
    end

    str
  end

  def client
    @client ||= first_client
  end

  # FIXME : make me deal with non local currency amounts
  def display_total_amount
    @display_total_amount ||= if !supplier_orders.empty?
                                number_to_currency(supplier_orders.map(&:offer_total_buying_price).compact.sum || 0, unit: Currency::LOCAL_CURRENCY) + total_amount_suffix
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

  def first_supplier_name
    if !supplier_orders.empty?
      supplier_orders.first.supplier_name
    end
  end

  # FIXME Ugly!, the 'order' association in particular...
  def first_supplier_link
    if !supplier_orders.empty? and !order.nil?
      link_to first_supplier_name, supplier_path(decorated_object.order.suppliers.first)
    end
  end

  def first_client
    if !supplier_orders.empty?
      supplier_orders.first.offer.client
    end
  end

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
