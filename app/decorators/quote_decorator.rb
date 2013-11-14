class QuoteDecorator < ApplicationDecorator
  # Associations

  def display_reference
    quote_reference.blank? ? "(NO REFERENCE ##{id})" : quote_reference
  end

  def order_links
    links = OrderDecorator.decorate_collection(self.orders).collect(&:link)
    links.uniq!
    links.join(',').html_safe
  end

  def order_dates
    dates = OrderDecorator.decorate_collection(self.orders).collect(&:display_purchase_date)
    dates.join(',').html_safe
  end

  # Maybe this belongs here instead of the model because this
  # is leaning more toward behavior than data
  def offer_details_mergable?(attr)
    details = self.offers.map(&attr).uniq
    details.count <= 1
  end

  def offer_spec_colspan
    merged_columns = [:supplier_name, :supplier, :remarks, :delivery, :warranty, :terms]
    counter = 0
    @offer_spec_colspan ||= merged_columns.collect do |attr|
      counter +=1 if offer_details_mergable?(attr)
      counter
    end.last
    @offer_spec_colspan
  end

  def quantity_labels
    requests.decorate.map{|x|
      x.to_label("label label-inverse")
    }.join(' ').html_safe
  end

  def solo_offer_supplier_name
    if @solo_offer ||= self.offers.first
      return @solo_offer.supplier_name
    end
  end

  def solo_offer_remarks
    if @solo_offer ||= self.offers.first
      return @solo_offer.remarks
    end
  end

  def solo_offer_delivery
    if @solo_offer ||= self.offers.first
      return @solo_offer.delivery
    end
  end

  def solo_offer_warranty
    if @solo_offer ||= self.offers.first
      return @solo_offer.warranty
    end
  end

  def solo_offer_terms
    if @solo_offer ||= self.offers.first
      return @solo_offer.terms
    end
  end

end
