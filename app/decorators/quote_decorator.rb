class QuoteDecorator < ApplicationDecorator
  decorates_association :requests

  def short_client_name
    if client_abbrev.blank?
      client_name
    else
      client_abbrev
    end
  end

  def display_reference
    quote_reference.blank? ? "(NO REFERENCE ##{id})" : quote_reference
  end

  def order_links
    links = orders.decorate.collect(&:link)
    links.uniq!
    links.join(",").html_safe
  end

  def order_dates
    dates = orders.decorate.collect(&:display_purchase_date)
    dates.join(",").html_safe
  end

  def order_links_with_date
    order_links = []
    OrderDecorator.decorate_collection(orders.uniq).each do |order|
      order_links << (order.link + "(#{order.display_purchase_date})".html_safe)
    end
    order_links.join(",").html_safe
  end

  # Maybe this belongs here instead of the model because this
  # is leaning more toward behavior than data
  def offer_details_mergable?(attr, supplier_id = nil)
    if supplier_id.blank?
      offers.map(&attr).uniq.count <= 1
    else
      supplier_offers = offers.where(supplier_id: supplier_id)
      supplier_offers.map(&attr).uniq.count <= 1
    end
  end

  def count_offers_with_internal_notes
    offers.where("offers.internal_notes <> ''").count
  end

  def offer_supplier_name_mergable?(supplier_id = nil)
    if supplier_id.blank?
      offers.map(&:supplier_name).present? && offers.supplier_hidden_in_print.empty?
    else
      offers.where(supplier_id: supplier_id).supplier_hidden_in_print.empty?
    end
  end

  def offer_spec_colspan(supplier_id = nil)
    mergable_columns = [:supplier_name, :supplier, :remarks, :delivery, :warranty, :terms]
    counter = 0
    @offer_spec_colspan ||= mergable_columns.collect do |attr|
      counter += 1 if offer_details_mergable?(attr, supplier_id)
      counter
    end.last

    @offer_spec_colspan
  end

  def quantity_labels
    labels = requests.decorate.map do |x|
      x.to_label("label label-inverse")
    end
    labels.join(" ").html_safe
  end

  def solo_offer_supplier_name(supplier_id = nil)
    if supplier_id.nil?
      o = offers
    else
      o = offers.where(supplier_id: supplier_id)
    end

    solo_offer.supplier_name if solo_offer(supplier_id) && o.supplier_hidden_in_print.empty?
  end

  def solo_offer_remarks(supplier_id = nil)
    solo_offer(supplier_id).remarks if solo_offer(supplier_id)
  end

  def solo_offer_delivery(supplier_id = nil)
    solo_offer(supplier_id).delivery if solo_offer(supplier_id)
  end

  def solo_offer_warranty(supplier_id = nil)
    solo_offer(supplier_id).warranty if solo_offer(supplier_id)
  end

  def solo_offer_terms(supplier_id = nil)
    solo_offer(supplier_id).terms if solo_offer(supplier_id)
  end

  def solo_offer(supplier_id = nil)
    @solo_offer ||= if supplier_id.nil?
                      offers.first
                    else
                      offers.where(supplier_id: supplier_id).first
                    end
  end
end
