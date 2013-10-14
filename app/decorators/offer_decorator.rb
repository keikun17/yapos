class OfferDecorator < Decorator

  # Decorated Associations
  def decorated_supplier_purchase
    @decorated_supplier_purchase ||= SupplierPurchaseDecorator.new(decorated_object.supplier_purchase)
  end
  # End of Decorated Association

  delegate :ordered_from_supplier_at, to: :decorated_supplier_purchase, prefix: false, allow_nil: true

  def actual_specs
    @actual_specs ||= (self.supplier_order_actual_specs || self.specs)
  end

  def supplier_purchase_link
    if self.supplier_purchase
      link_to self.supplier_purchase_reference, print_supplier_purchase_path(self.supplier_purchase)
    else
      self.supplier_order_reference
    end
  end

  def edit_supplier_purchase_link
    if self.supplier_purchase
      link = link_to "edit", edit_supplier_purchase_path(self.supplier_purchase)
      raw "(#{link})"
    else
      self.supplier_order_reference
    end
  end

  def supplier_order_reference
    off_ref = __getobj__.supplier_order_reference
    off_ref.blank? ? "Not Ordered" : off_ref
  end

  def request_unit
    __getobj__.request_unit.blank? ? 'Unit' : __getobj__.request_unit
  end

  def request
    @request ||= RequestDecorator.new(__getobj__.request)
  end

  # Takes options hash
  #   quantity_class  : class used for the quantity + uom span-label
  def display_specs(html_options = {})
    html_options[:class] ||= 'label label-inverse'

    content_tag(:div) do
      inner = quantity_label(html_options[:class])
      inner.safe_concat(' ')
      inner.safe_concat(self.specs)
    end
  end

  def display_actual_specs(text = "Actual:", html_options = {})
    html_options[:class] ||= 'label label-important'

    if !__getobj__.supplier_order_actual_specs.blank?
      label = content_tag(:span, text, class: html_options[:class])
      label.safe_concat(__getobj__.supplier_order_actual_specs)
    end
  end

  def display_summary
    @display_summary ||= summary || link_to('Please edit and add offer spec summary/code', edit_quote_path(__getobj__.quote))
  end

  def quantity_label(label_class="")
    RequestDecorator.new(__getobj__.request).to_label(label_class)
  end

  def complete_quantity
    [ self.request_quantity.to_s, self.request_unit ].join(' ')
  end

  def display_status
    if self.supplier_order_delivered?
      "Delivered"
    elsif self.supplier_order_ordered_from_supplier?
      "Ordered"
    else
      "Not Ordered"
    end
  end

  # If Dollars
  #   $40.00/unit
  # If PHP
  def display_selling_price
    str = number_to_currency(self.selling_price || 0, unit: self.currency)
    str = str + "/#{self.request_unit}"
    if !self.price_suffix.blank?
      str = str + " (#{self.price_suffix})"
    end
    str
  end

  def display_buying_price
    str = number_to_currency(self.buying_price || 0, unit: self.currency)
    str = str + "/#{self.request_unit}"
    if !self.price_suffix.blank?
      str = str + " (#{self.price_suffix})"
    end
    str
  end

  def display_total_buying_price
    str = number_to_currency(self.total_buying_price || 0, unit: Currency::LOCAL_CURRENCY)
    if !self.price_suffix.blank?
      str = str + " (#{self.price_suffix})"
    end
    str
  end

  def display_total_selling_price
    str = number_to_currency(self.total_selling_price || 0, unit: Currency::LOCAL_CURRENCY)
    if !self.price_suffix.blank?
      str = str + " (#{self.price_suffix})"
    end
    str
  end

  def price_suffix
    @suffix ||= [self.price_vat_status,self.price_basis].compact.join(" ")
  end

  def estimated_manufacture_end_date
    if date = __getobj__.supplier_order_estimated_manufactured_at
      date.to_date.to_s
    else
      display_none
    end
  end

  def estimated_delivery_date
    if date = __getobj__.supplier_order_estimated_delivered_at
      date.to_date.to_s
    else
      display_none
    end
  end

  def delivered_at
    if date = __getobj__.supplier_order_delivered_at
      date.to_date.to_s
    else
      display_none
    end
  end

  def quote_date
    if !decorated_object.quote_date.blank?
      decorated_object.quote_date.to_date.to_s(:long)
    end
  end

  def display_purchase_date
    if decorated_object.order
      order = OrderDecorator.new(decorated_object.order)
      if order
        order.display_purchase_date
      else
        nil
      end
    end
  end

  private

    def display_none
      'None'
    end

end
