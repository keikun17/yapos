class Order < ActiveRecord::Base
  include Elasticearch::Model::Search
  include Elasticearch::Model::Callbacks

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
  has_many :quotes, :through => :offers, :uniq => true

  has_many :clients, :through => :quotes, :uniq => true
  has_many :suppliers, :through => :offers, :uniq => true
  has_many :supplier_orders, :through => :offers
  has_many :supplier_purchases, through: :supplier_orders, uniq: true

  validates_presence_of :reference
  validates_associated :attachments

  accepts_nested_attributes_for :quotes
  accepts_nested_attributes_for :offers
  accepts_nested_attributes_for :attachments,
    :allow_destroy => true,
    :reject_if => lambda { |a| a[:document].nil? }

  scope :not_yet_ordered, -> { includes( offers: :supplier_order ).where( "supplier_orders.reference = '' or supplier_orders.reference is null" ).where.not(offers: {id: :null}) }
  scope :ordered, -> { includes(offers: :supplier_order).where( "supplier_orders.reference != '' and supplier_orders.reference is not null" ) }
  # Tire/ElasticSearch Configuration

  mapping do
    indexes :purchase_date, {type: 'date', include_in_all: false}
  end

  def to_indexed_json
    {
      reference: self.reference,
      client_names: self.client_names,
      supplier_names: supplier_names,
      status: 'implement',
      purchase_date: self.purchase_date,
      actual_specs: actual_specs,
      offer_specs: offer_specs,
      offer_summaries: offer_summaries
    }.to_json
  end

  # /-- Tire/ElasticSearch config

  def purchase_selected_offers
    # TODO : impplement 'client_purchased' scope on Offer instead of an iteration
    # and condition checks
    # 
    # e.g. : self.offers.client_purchased.map(&:purchase_from_supplier)
    self.offers.each do |offer|
      unless offer.supplier_order.nil? or offer.supplier_order.reference.blank?
        offer.purchase_from_supplier
      end
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

