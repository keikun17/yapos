class OfferDecorator < ApplicationDecorator

  # Decorated Associations
  def decorated_supplier_purchase
    @decorated_supplier_purchase ||= SupplierPurchaseDecorator.new(self.supplier_purchase)
  end
  # End of Decorated Association

  def actual_specs
    @actual_specs ||= (self.supplier_order_actual_specs || self.specs)
  end

  def ordered_from_supplier_at
    if self.supplier_purchase.nil?
      "Item not yet purchased from Supplier"
    else
      decorated_supplier_purchase.ordered_from_supplier_at
    end
  end

  def supplier_purchase_link
    if self.supplier_purchase
      h.link_to self.supplier_purchase_reference, h.print_supplier_purchase_path(self.supplier_purchase)
    else
      self.supplier_order_reference
    end
  end

  def edit_supplier_purchase_link
    if self.supplier_purchase
      link = h.link_to "edit", h.edit_supplier_purchase_path(self.supplier_purchase)
      "(#{link})".html_safe
    else
      self.supplier_order_reference
    end
  end

  def supplier_order_reference
    super.blank? ? "Not Ordered" : super
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

  def display_summary
    @display_summary ||= if summary.blank?
                           h.link_to('Please enter the actual spec for this offer', h.edit_quote_path(self.quote))
                         else
                           summary
                         end

  end

  def quantity_label(label_class="")
    request.decorate.to_label(label_class)
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

    str = h.number_to_currency(self.buying_price || 0, unit: self.currency)
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
    str = h.number_to_currency(total_price || 0, unit: self.currency)

    if with_suffix == true and !self.price_suffix.blank?
      str = str + " (#{self.price_suffix})"
    end

    str
  end

  def total_local_buying_price
    str = h.number_to_currency(self.total_buying_price || 0, unit: Currency::LOCAL_CURRENCY)
    if !self.price_suffix.blank?
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

  def estimated_manufacture_end_date
    if date = self.supplier_order_estimated_manufactured_at
      date.to_date.to_s
    else
      if supplier_order
        h.content_tag :p do
          html  = h.link_to_modal("Set Manufacture end date", self.supplier_order, {class: 'btn btn-small btn-success', modal_id: 'exworks'})
          html << (h.render 'supplier_orders/modals/set_manufacture_date', modal_id: h.dom_id(supplier_order) + 'exworks', supplier_order: supplier_order.decorate)
        end
      else
        display_none
      end
    end
  end

  def estimated_delivery_date
    if date = self.supplier_order_estimated_delivered_at
      date.to_date.to_s
    else
      if supplier_order
        h.content_tag :p do
          html  = h.link_to_modal("Set Estimated Delivery", self.supplier_order, {class: 'btn btn-small btn-success', modal_id: 'eta'})
          html << (h.render 'supplier_orders/modals/set_estimated_delivery_date', modal_id: h.dom_id(supplier_order) + 'eta', supplier_order: supplier_order.decorate)
        end
      else
        display_none
      end
    end
  end

  def delivered_at
    if date = self.supplier_order_delivered_at
      date.to_date.to_s
    else
      if supplier_order
        h.content_tag :p do
          html  = h.link_to_modal("Set Delivery", self.supplier_order, {class: 'btn btn-small btn-success', modal_id: 'delivery'})
          html << (h.render 'supplier_orders/modals/mark_as_delivered', modal_id: h.dom_id(supplier_order) + 'delivery', supplier_order: supplier_order.decorate)
        end
      else
        display_none
      end
    end
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

  private

    def display_none
      if self.client_ordered?
        h.content_tag :span, "Please Edit", class: 'muted'
      else
        'No PO'
      end
    end

end
