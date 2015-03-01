class Order < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  attr_accessible :purchase_date,
    :reference,
    :quotes_attributes,
    :quotes,
    :custom_quote_reference,
    :description,
    :client_id,
    :supplier_id,
    :attachments_attributes,
    :offers_attributes

  has_many :attachments, :as => :attachable

  has_many :offers,
    :foreign_key => 'order_reference',
    :primary_key => 'reference'

  has_many :supply_offers, -> { where.not(service: true) },
    class_name: 'Offer',
    foreign_key: 'order_reference',
    primary_key: 'reference'

  has_many :quotes, -> {uniq}, :through => :offers
  has_many :clients, -> {uniq}, :through => :quotes
  has_many :suppliers, -> {uniq}, :through => :offers
  has_many :supplier_orders, -> {uniq}, :through => :supply_offers
  has_many :supplier_purchases, -> {uniq}, through: :supplier_orders

  validates_presence_of :reference
  validates_associated :attachments

  accepts_nested_attributes_for :quotes
  accepts_nested_attributes_for :offers
  accepts_nested_attributes_for :attachments,
    :allow_destroy => true,
    :reject_if => lambda { |a| a[:document].nil? }

  scope :not_yet_ordered, -> { includes( :supplier_orders ).references(:supplier_orders).where( "supplier_orders.reference = '' or supplier_orders.reference is null" )}
  scope :ordered, -> { includes( :supplier_orders).references(:supplier_orders).where( "supplier_orders.reference != '' and supplier_orders.reference is not null" ) }
  # Tire/ElasticSearch Configuration

  def as_indexed_json(options={})
    self.as_json(
      methods: [
        :supplier_names, :offer_specs, :actual_specs,
        :offer_specs, :offer_summaries, :client_names
      ],
      only: [
        :reference, :client_names, :supplier_names, :purchase_date,
        :actual_specs, :offer_specs, :offer_summaries
      ]
    )
  end

  # /-- Tire/ElasticSearch config

  def purchase_selected_offers
    # TODO : impplement 'client_purchased' scope on Offer instead of an iteration
    # and condition checks
    #
    # e.g. : self.offers.client_purchascd.map(&:purchase_from_supplier)
    self.offers.each do |offer|
      offer.purchase_from_supplier
    end
  end

  def actual_specs
    as = supplier_orders.map(&:actual_specs)
    as = as.uniq.compact
    as
  end

  def offer_specs
    os = offers.map(&:specs)
    os = os.uniq.compact
    os
  end

  def offer_summaries
    osum = offers.map(&:summary)
    osum = osum.uniq.compact
    osum
  end

  def clear_quotes
    self.quotes.update_all(:order_id => nil)
  end

  def client_names
    self.clients.uniq.map(&:name)
  end

  def supplier_names
    self.suppliers.uniq.map(&:name)
  end

end

# == Schema Information
#
# Table name: orders
#
#  id                     :integer          not null, primary key
#  reference              :string(255)
#  purchase_date          :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  custom_quote_reference :string(255)
#  description            :text
#  supplier_id            :integer
#  client_id              :integer
#

