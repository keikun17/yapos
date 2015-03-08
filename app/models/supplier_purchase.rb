class SupplierPurchase < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  attr_accessible :reference,
    #order_id, #TODO : Create a migration that removes the order_id column, we
    #                  we don't need this anymore because we are getting orders
    #                  thru the :offers association
    :recipient,
    :address,
    :delivery,
    :price_basis,
    :remarks,
    :terms,
    :warranty,
    :ordered_at,
    :signatory,
    :signatory_position,
    :hide_client_in_print

  # belongs_to :order
  has_many :supplier_orders,
    primary_key: :reference,
    foreign_key: :reference

  has_many :offers, through: :supplier_orders

  has_many :clients, -> {uniq},  through: :offers
  has_many :suppliers, -> {uniq},  through: :offers
  has_many :quotes, -> {uniq},   through: :offers
  has_many :orders, -> {uniq}, through: :offers

  validate :reference, uniqueness: true

  def as_indexed_json(options={})
    self.as_json(
      include: {
        clients: {only: :name},
        suppliers: {only: :name},
      },


      only: [
        :reference, :supplier_specs
      ]
    )
  end

  def reindex
    begin
      __elasticsearch__.delete_document
    rescue
      # Do nothing, carry on
    end
    __elasticsearch__.index_document
  end

  def supplier_specs
    as = supplier_orders.map(&:actual_specs)
    as = as.uniq.compact
    as
  end

  def actual_specs
    as = supplier_orders.map(&:actual_specs)
    as = as.uniq.compact
    as
  end
  def order_date
    ordered_at.to_date.to_s(:long) if ordered_at
  end

  #FIXME : UGLY
  def supplier_name
    ActiveSupport::Deprecation.warn("Yapos : Deprecate this in favor of `supplier_names` decorator")
    unless supplier_orders.empty?
      supplier_orders.first.supplier_name
    end
  end

  #FIXME : UGLY
  def supplier_address
    ActiveSupport::Deprecation.warn("Yapos : Deprecate this and only show the address when the printable PO has a supplier filter specified")
    unless supplier_orders.empty?
      supplier_orders.first.supplier_address
    end
  end

  #FIXME : UGLY
  def client
    ActiveSupport::Deprecation.warn("Yapos : Deprecate this. There should be no more use cases that uses this")
    supplier_orders.first.offer.client
  end

end

# == Schema Information
#
# Table name: supplier_purchases
#
#  id                   :integer          not null, primary key
#  order_id             :integer
#  reference            :string(255)
#  recipient            :string(255)
#  string               :string(255)
#  address              :string(255)
#  delivery             :text
#  price_basis          :text
#  remarks              :text
#  terms                :text
#  warranty             :text
#  ordered_at           :datetime
#  signatory            :string(255)
#  signatory_position   :string(255)
#  hide_client_in_print :boolean
#  created_at           :datetime
#  updated_at           :datetime
#
