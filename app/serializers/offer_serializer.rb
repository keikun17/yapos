class OfferSerializer < ActiveModel::Serializer

  self.root = false

  attributes :id, :order_id, :quote_id, :quote_reference,:order_reference,
    :display_purchase_date, :complete_quantity, :summary, :supplier_name,
    :estimated_manufacture_end_date, :estimated_delivery_date, :delivered_at

  def order_id
    object.order.id if object.order
  end

  def quote_id
    object.quote.id if object.quote
  end

end
