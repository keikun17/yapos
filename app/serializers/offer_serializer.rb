class OfferSerializer < ActiveModel::Serializer

  self.root = false

  attributes :id, :order_id, :quote_id, :quote_reference,:order_reference,
    :order_purchase_date, :complete_quantity, :summary, :supplier_name,
    :estimated_manufacture_end_date, :estimated_delivery_date, :delivered_at

  def order_id
    object.order.id if object.order
  end

  def quote_id
    object.quote.id if object.quote
  end

  def order_purchase_date
    if object.order and object.order.purchase_date
        object.order.purchase_date.to_date
    end
  end

end

# == Schema Information
#
# Table name: offers
#
#  id                         :integer          not null, primary key
#  request_id                 :integer
#  supplier_id                :integer
#  specs                      :text(65535)
#  buying_price               :decimal(15, 2)
#  selling_price              :decimal(15, 2)
#  currency                   :string(255)
#  currency_conversion        :float(24)
#  order_reference            :string(255)
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  remarks                    :text(65535)
#  terms                      :string(255)
#  delivery                   :string(255)
#  warranty                   :string(255)
#  price_vat_status           :string(255)
#  total_buying_price         :decimal(15, 2)
#  total_selling_price        :decimal(15, 2)
#  price_basis                :string(255)
#  summary                    :string(255)
#  delivery_receipt_reference :string(255)
#  sales_invoice_reference    :string(255)
#  vendor_item_code           :string(255)
#  vendor_item_id             :string(255)
#  hide_supplier_in_print     :boolean
#  internal_notes             :text(65535)
#  buying_currency            :string(255)
#  service                    :boolean          default(FALSE)
#  from_stock                 :boolean          default(FALSE)
#
