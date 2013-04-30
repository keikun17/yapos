class OfferDecorator < Decorator

  def supplier_order_reference
    __getobj__.supplier_order_reference || 'Not yet ordered'
  end

  # If Dollars 
  #   $ 40.00/unit
  # If PHP 
  def display_selling_price
    #TODO:IMPLEMENT
    #{offer.currency} #{offer.selling_price} (#{offer.selling_price_tax_status})
    content_tag :i do
      "$40.00/Unit"
    end
  end

  def delivery
    #TODO:IMPLEMENT
    content_tag :i do
      "30-40 days"
    end
  end

  def warranty
    #TODO:IMPLEMENT
    content_tag :i do
      "1 Year Under normal operating conditions"
    end
  end

  def terms
    #TODO:IMPLEMENT
    content_tag :i do
      "30 days advance payment"
    end
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
