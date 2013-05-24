class OfferDecorator < Decorator

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
  def summary(options = {})
    content_tag(:div) do
      inner = quantity_label(options[:quantity_class])
      inner.safe_concat(' ')
      inner.safe_concat(self.specs)
    end
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
      str = str + "(#{self.price_suffix})"
    end
    str
  end

  def display_buying_price
    str = number_to_currency(self.buying_price || 0, unit: self.currency)
    str = str + "/#{self.request_unit}"
    if !self.price_suffix.blank?
      str = str + "(#{self.price_suffix})"
    end
    str
  end

  def display_total_buying_price
    str = number_to_currency(self.total_buying_price || 0, unit: Currency::LOCAL_CURRENCY)
    if !self.price_suffix.blank?
      str = str + "(#{self.price_suffix})"
    end
    str
  end

  def display_total_selling_price
    str = number_to_currency(self.total_selling_price || 0, unit: Currency::LOCAL_CURRENCY)
    if !self.price_suffix.blank?
      str = str + "(#{self.price_suffix})"
    end
    str
  end

  def price_suffix
    @suffix ||= [self.price_vat_status,self.price_basis].compact.join(" ")
  end

  def ordered_from_supplier_at
    if date = __getobj__.supplier_purchase_ordered_at
      date.to_date.to_s
    else
       'Not Ordered'
    end
  end

  def estimated_manufacture_end_date
    if date = __getobj__.supplier_order_estimated_manufactured_at
      date.to_date.to_s
    else
      display_none
    end
  end

  def actual_manufacture_end_date
    if date = __getobj__.supplier_order_manufactured_at
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

  private


  def display_none
    'None'
  end
end
