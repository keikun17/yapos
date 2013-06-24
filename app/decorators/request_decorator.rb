class RequestDecorator < Decorator
  def offered_brands
    self.offers.map(&:supplier_name).join(',')
  end

  def offer_count
    self.offers.count
  end

  def offset_offer_count(offset)
    offer_count + offset.to_i
  end

  def display_quantity
    if (str = "#{quantity} #{unit}").blank?
      str = "1.00 Unit"
    end
    str
  end

  def to_label(label_class)
    content_tag(:span,  class: label_class) do
      display_quantity
    end
  end


end
