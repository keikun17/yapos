class SupplierPurchase < ActiveRecord::Base
  attr_accessible :order_id,
    :reference,
    :recipient,
    :address,
    :delivery,
    :price_basis,
    :remarks,
    :terms,
    :warranty,
    :ordered_at,
    :signatory,
    :signatory_position

  belongs_to :order
  has_many :offers, through: :supplier_orders
  has_many :quotes, through: :offers

  has_many :supplier_orders,
    primary_key: :reference,
    foreign_key: :reference

  #FIXME : UGLY
  def supplier_name
    unless supplier_orders.empty?
      supplier_orders.first.supplier_name
    end
  end

  #FIXME : UGLY
  def supplier_address
    unless supplier_orders.empty?
      supplier_orders.first.supplier_address
    end
  end

  #FIXME : UGLY
  def client
    supplier_orders.first.offer.client
  end

  def client_name
    client.name
  end
end

# == Schema Information
#
# Table name: supplier_purchases
#
#  id                 :integer          not null, primary key
#  order_id           :integer
#  reference          :string(255)
#  recipient          :string(255)
#  string             :string(255)
#  address            :string(255)
#  delivery           :text
#  price_basis        :text
#  remarks            :text
#  terms              :text
#  warranty           :text
#  ordered_at         :datetime
#  signatory          :string(255)
#  signatory_position :string(255)
#

