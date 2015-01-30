class QuoteDecorator < ApplicationDecorator
  # Associations

  def short_client_name
    unless client_abbrev.blank?
      client_abbrev
    else
      client_name
    end
  end
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


  def order_links_with_date
    order_links = []
    OrderDecorator.decorate_collection(self.orders.uniq).each do |order|
      order_links << (order.link + "(#{order.display_purchase_date})".html_safe)
    end
    order_links.join(',').html_safe
  end

  # Maybe this belongs here instead of the model because this
  # is leaning more toward behavior than data
  def offer_details_mergable?(attr, supplier_id = nil)
    if supplier_id.blank?
      self.offers.map(&attr).uniq.count <= 1
    else
      supplier_offers = self.offers.where(supplier_id: supplier_id)
      supplier_offers.map(&attr).uniq.count <= 1
    end
  end

  def count_offers_with_internal_notes
    self.offers.where("offers.internal_notes <> ''").count
  end

  def offer_supplier_name_mergable?(supplier_id = nil)
    if supplier_id.blank?
      self.offers.map(&:supplier_name).uniq.count <= 1 and self.offers.supplier_hidden_in_print.empty?
    else
      supplier_offers = self.offers.where(supplier_id: supplier_id)
      supplier_offers.map(&:supplier_name).uniq.count <= 1 and supplier_offers.supplier_hidden_in_print.empty?
    end
  end

  def offer_spec_colspan(supplier_id = nil)
    mergable_columns = [:supplier_name, :supplier, :remarks, :delivery, :warranty, :terms]
    counter = 0
    @offer_spec_colspan ||= mergable_columns.collect do |attr|
      counter +=1 if offer_details_mergable?(attr, supplier_id)
      counter
    end.last

    @offer_spec_colspan
  end

  def quantity_labels
    requests.decorate.map{|x|
      x.to_label("label label-inverse")
    }.join(' ').html_safe
  end

  def solo_offer_supplier_name(supplier_id = nil)
    if supplier_id.nil?
      o = self.offers
    else
      o = self.offers.where(supplier_id: supplier_id)
    end

    if o.supplier_hidden_in_print.empty?
      if @solo_offer ||= o.first
        return @solo_offer.supplier_name
      end
    end
  end

  def solo_offer_remarks(supplier_id = nil)
    if supplier_id.nil?
      o = self.offers
    else
      o = self.offers.where(supplier_id: supplier_id)
    end

    if @solo_offer ||= o.first
      return @solo_offer.remarks
    end
  end

  def solo_offer_delivery(supplier_id = nil)
    if supplier_id.nil?
      o = self.offers
    else
      o = self.offers.where(supplier_id: supplier_id)
    end

    if @solo_offer ||= o.first
      return @solo_offer.delivery
    end
  end

  def solo_offer_warranty(supplier_id = nil)
    if supplier_id.nil?
      o = self.offers
    else
      o = self.offers.where(supplier_id: supplier_id)
    end

    if @solo_offer ||= o.first
      return @solo_offer.warranty
    end
  end

  def solo_offer_terms(suppier_id = nil)
    if supplier_id.nil?
      o = self.offers
    else
      o = self.offers.where(supplier_id: supplier_id)
    end

    if @solo_offer ||= o.first
      return @solo_offer.terms
    end
  end

end
