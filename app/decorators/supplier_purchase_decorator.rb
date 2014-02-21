class SupplierPurchaseDecorator < ApplicationDecorator

  def supplier_name
    @supplier_name ||=  first_supplier_name
  end

  def link_to_supplier
    @supplier_link ||= first_supplier_link
  end

  def ordered_from_supplier_at(options={})
    options[:required_text] ||= 'Please Fill Up'
    if self.ordered_at.nil?
      str = h.content_tag :i do
        h.link_to options[:required_text], h.edit_supplier_purchase_path(self)
      end
    else
      str = self.ordered_at.to_date.to_s(:long)
    end

    str
  end

  def client
    @client ||= first_client
  end

  def display_total_amount
    @display_total_amount ||= if !supplier_orders.empty?
                                h.number_to_currency(supplier_orders.map(&:offer_total_currency_buying_price).compact.sum || 0, unit: supplier_orders.first.offer.currency) + total_amount_suffix
                              else
                                h.number_to_currency(0, unit: Currency::LOCAL_CURRENCY) + total_amount_suffix
                              end
  end

  def client_name
    client.name if client
  end

  def offer
    @offer ||= OfferDecorator.new(self.offer)
  end

  private

  def first_supplier_name
    if !supplier_orders.empty?
      supplier_orders.first.supplier_name
    end
  end

  # FIXME Ugly!, the 'order' association in particular...
  def first_supplier_link
    if !supplier_orders.empty? and !order.nil? and self.order.suppliers.first.present?
      h.link_to first_supplier_name, h.supplier_path(self.order.suppliers.first)
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
