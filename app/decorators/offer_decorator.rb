class OfferDecorator < ApplicationDecorator
  decorates_association :request
  decorates_association :supplier_purchase

  delegate :ordered_from_supplier_at, to: :supplier_purchase, prefix: false, allow_nil: true

  def actual_specs
    @actual_specs ||= (self.supplier_order_actual_specs || self.specs)
  end

  def supplier_purchase_link
    if self.supplier_purchase
      h.link_to self.supplier_purchase_reference, self.supplier_purchase, class: 'label label-supplier-order'
    else
      self.supplier_order_reference
    end
  end

  def edit_supplier_purchase_link
    if self.supplier_order_reference.present?
      link = h.link_to "Edit", h.edit_supplier_purchase_path(self.supplier_purchase)
      "(#{link})".html_safe
    else
      self.supplier_order_reference
    end
  end

  def supplier_order_reference
    super.blank? ? "Not Yet Ordered" : super
  end

  def display_specs(html_options = {})
    html_options[:class] ||= 'label label-inverse'

    h.content_tag(:div) do
      inner = quantity_label(html_options[:class])
      inner.safe_concat(' ')
      inner.safe_concat(self.specs)
    end
  end

  def display_actual_specs(text = "Actual:", html_options = {})
    html_options[:class] ||= 'label label-important'

    if !self.supplier_order_actual_specs.blank?
      label = h.content_tag(:span, text, class: html_options[:class])
      label.safe_concat(self.supplier_order_actual_specs)
    end
  end

  def quantity_label(label_class="")
    request.decorate.to_label(label_class)
  end

  def complete_quantity
    [ self.request_quantity.to_s, self.request_unit ].join(' ')
  end

  def display_status
    if self.delivered?
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
    str = h.number_to_currency(self.selling_price || 0, unit: self.currency)
    str = str + "/#{self.request_unit}"
    if !self.price_suffix.blank?
      str = str + " (#{self.price_suffix})"
    end
    str
  end

  # Options
  # with_suffix: set to true if you want to return with suffix (VAT, Price
  # basis)
  def display_buying_price(options = {})
    with_suffix = options[:with_suffix]

    str = h.number_to_currency(self.buying_price || 0, unit: self.buying_currency)
    str = str + "/#{self.request_unit}"

    if with_suffix == true and !self.price_suffix.blank?
      str = str + " (#{self.price_suffix})"
    end

    str
  end

  # Options
  # with_suffix: set to true if you want to return with suffix (VAT, Price
  # basis)
  def display_total_buying_price(options = {})
    with_suffix = options[:with_suffix]

    total_price = (self.request_quantity || 0 ) * (self.buying_price || 0)
    str = h.number_to_currency(total_price || 0, unit: self.buying_currency)

    if with_suffix == true and !self.price_suffix.blank?
      str = str + " (#{self.price_suffix})"
    end

    str
  end

  def display_total_selling_price
    str = h.number_to_currency(self.total_selling_price || 0, unit: Currency::LOCAL_CURRENCY)
    if !self.price_suffix.blank?
      str = str + " (#{self.price_suffix})"
    end
    str
  end

  def display_total_selling_price_by_currency
    str = h.number_to_currency(self.total_currency_selling_price || 0, unit: self.currency)
    if !self.price_suffix.blank?
      str = str + " (#{self.price_suffix})"
    end
    str
  end

  def price_suffix
    @suffix ||= [self.price_vat_status,self.price_basis].compact.join(" ")
  end

  def quote_date
    super.blank? ? self.quote_date.to_date.to_s(:long) : super
  end

  def display_purchase_date
    if self.order
      order = self.order.decorate
      if order
        order.display_purchase_date
      else
        nil
      end
    end
  end

  def loss?
    if (buying_currency != currency) || (buying_price.nil? && selling_price.nil?) || buying_price.nil?
      return false
    elsif  buying_price.present? and !selling_price.present?
      return true
    else
      buying_price >= selling_price
    end
  end

  private

  def display_none
    if self.client_ordered?
      h.content_tag :span, "Please Edit", class: 'muted'
    else
      'No PO'
    end
  end

end
