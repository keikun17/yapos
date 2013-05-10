class SupplierPurchase < ActiveRecord::Base
  attr_accessible :order_id,
    :recipient,
    :address,
    :delivery,
    :price_basis,
    :remarks,
    :terms,
    :warranty,
    :ordered_at

  belongs_to :order
  has_many :supplier_orders,
    primary_key: :reference,
    foreign_key: :reference

  def supplier_name
    supplier_orders.first.supplier_name
  end

  def client
    supplier_orders.first.offer.client
  end

  def client_name
    client.name
  end
end
  
