class OfferDecorator < Decorator

  def supplier_order_reference
    __getobj__.supplier_order_reference || 'Not yet ordered'
  end

  def request_unit
    __getobj__.request_unit.blank? ? 'Unit' : __getobj__.request_unit
  end

  def summary
    str = ""
    if self.request_quantity && self.request_unit
      str = self.request_quantity.to_s
      str += ' ' +  self.request_unit + ' '
    end
    str += self.specs
  end

  # If Dollars
  #   $40.00/unit
  # If PHP
  def display_selling_price
    str = number_to_currency(self.selling_price || 0, unit: self.currency)
    str = str + "/#{self.request_unit}"
    if !self.price_vat_status.blank?
      str = str + "(#{self.price_vat_status})"
    end
    str
  end

  def display_status
    if self.supplier_order_delivered?
      "Delivered"
    elsif self.supplier_order_ordered_from_supplier?
      "Ordered"
    else
      "Not yet ordered"
    end
  end

  def display_buying_price
    str = number_to_currency(self.buying_price || 0, unit: self.currency)
    str = str + "/#{self.request_unit}"
    if !self.price_vat_status.blank?
      str = str + "(#{self.price_vat_status})"
    end
    str
  end

  def display_total_buying_price
    str = number_to_currency(self.total_buying_price || 0, unit: Currency::LOCAL_CURRENCY)
    if !self.price_vat_status.blank?
      str = str + "(#{self.price_vat_status})"
    end
    str
  end

  def display_total_selling_price
    str = number_to_currency(self.total_selling_price || 0, unit: Currency::LOCAL_CURRENCY)
    if !self.price_vat_status.blank?
      str = str + "(#{self.price_vat_status})"
    end
    str
  end

  def ordered_from_supplier_at
    if date = __getobj__.supplier_order_ordered_at
      date.to_date.to_s
    else
       'Not yet ordered'
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
