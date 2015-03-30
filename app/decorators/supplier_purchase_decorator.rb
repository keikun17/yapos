class SupplierPurchaseDecorator < ApplicationDecorator

  def supplier_name
    @supplier_name ||=  first_supplier_name
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

  # NOTE: This uses the currency of the first offer
  def display_total_amount(options = {})
    # FIXME / TODO : modify this method in a way where if the offer's currency
    # are different display a message saying "Cannot display due to difference
    # in currency among offers"
    with_suffix = options[:with_suffix]

    @display_total_amount ||= if !supplier_orders.empty?
                                h.number_to_currency(supplier_orders.map(&:offer_total_currency_buying_price).compact.sum || 0, unit: supplier_orders.first.offer.buying_currency)
                              else
                                h.number_to_currency(0, unit: Currency::LOCAL_CURRENCY)
                              end
    if with_suffix
      @display_total_amount += total_amount_suffix
    end
    @display_total_amount
  end

  def client_names
    clients.map(&:name).join(', ')
  end

  def supplier_names
    suppliers.map(&:name).join(', ')
  end

  def offer
    @offer ||= OfferDecorator.new(self.offer)
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
