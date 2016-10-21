class RequestDecorator < ApplicationDecorator

  delegate_all

  def offered_brands
    offers.map(&:supplier_name).join(',')
  end

  def offer_count
    offers.count
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
    h.content_tag(:span,  class: label_class) do
      display_quantity
    end
  end

  def item_code_link
    if !self.item_code.blank? && self.quote.client
      h.link_to "Item Code : #{self.item_code}", h.client_client_item_path(client_id: self.quote.client, id: self.item_code), class: 'client-item-code'
    end
  end

end
