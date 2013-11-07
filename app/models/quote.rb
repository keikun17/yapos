class Quote < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  attr_accessible :description,
    :signatory,
    :signatory_position,
    :contact_person,
    :quantity,
    :quote_date,
    :quote_reference,
    :supplier_id,
    :status,
    :client_id,
    :requests_attributes,
    :attachments_attributes,
    :remarks,
    :internal_notes,
    :state

  has_many :attachments, :as => :attachable
  has_many :requests, dependent: :destroy
  has_many :offers, :through => :requests

  has_many :suppliers, :through => :offers
  has_many :orders, :through => :offers

  has_many :supplier_orders, through: :orders

  validates_associated :attachments
  validates_associated :requests

  accepts_nested_attributes_for :attachments,
    :allow_destroy => true,
    :reject_if => lambda { |a| a[:document].nil? }

  accepts_nested_attributes_for :requests,
    :allow_destroy => true,
    :reject_if => lambda { |r| r[:supplier].nil? &&
                           r[:specs].blank? &&
                           r[:remarks].blank?  }

  belongs_to :client
  belongs_to :supplier

  delegate :reference, :to => :order, :allow_nil => true, :prefix => true
  delegate :name, :to => :client, :allow_nil => true, :prefix => true
  delegate :name, :to => :supplier, :allow_nil => true, :prefix => true

  scope :unawarded, -> { where(:order_id => nil) }
  scope :not_closed, where("quotes.status not in ('Cancelled', 'No Quote', 'Not Awarded')");

  scope :with_pending_requests, -> do
    not_closed.includes(:offers).where(offers: {request_id: nil})
  end

  default_scope -> { order('quotes.quote_date desc, quotes.id desc') }

  scope :pending_client_order, not_closed.includes(:requests).merge(Request.pending_client_order)
  scope :pending_supplier_order, -> do
    s = not_closed.includes([:supplier_orders, :offers])

    # Where the Supplier order has no Supplier PO Reference
    s = s.where("supplier_orders.reference = '' or supplier_orders.reference is null")

    # Quotes that at least has at least 1 client ordered offer
    s = s.where("offers.id is not null").where("offers.order_reference <> ''")

    # s = s.where("offers.order_reference <> ''")
    s
  end

  # Quotes that needs to be have the ex-works date set
  scope :for_scheduling, -> do
    s = not_closed.includes(:supplier_orders)
    s = s.where("supplier_orders.reference != '' or supplier_orders.reference is not null")
    s = s.where("supplier_orders.estimated_manufactured_at is null")
    s = s.where("supplier_orders.delivered_at is null")
    s
  end

  scope :manufacturing, -> do
    s = not_closed.includes(:supplier_orders)
    s = s.where("supplier_orders.reference != '' or supplier_orders.reference is not null")
    s = s.where("'#{Time.now.to_s(:db)}' < supplier_orders.estimated_manufactured_at")
    s = s.where("supplier_orders.delivered_at is null")
    s
  end

  scope :for_delivery, -> do
    s = not_closed.includes(:supplier_orders)
    s = s.where("'#{Time.now.to_s(:db)}' >= supplier_orders.estimated_manufactured_at")
    s = s.where("supplier_orders.delivered_at is null")
    s
  end

  # Tire/ElasticSearch Configuration

  mapping do

    # For more info abou the #includ_in_all key
    # http://www.elasticsearch.org/guide/reference/mapping/all-field/
    indexes :quote_date, {type: 'date', include_in_all: false}

  end

  def to_indexed_json
    {
      quote_reference: self.quote_reference,
      client_name: self.client_name,
      supplier_names: supplier_names,
      display_status: self.display_status,
      description: description,
      request_specs: request_specs,
      offered_specs: offered_specs,
      offer_summaries: offer_summaries,
      quote_date: quote_date

    }.to_json
  end

  # /-- Tire/ElasticSearch config

  def request_specs
    r = requests.map(&:specs)
    r = r.uniq.compact
    r
  end

  def supplier_po
    "implement"
  end

  def offered_specs
    o = offers.map(&:specs)
    o = o.uniq.compact
    o
  end

  def offer_summaries
    osum = offers.map(&:summary)
    osum = osum.uniq.compact
    osum
  end

  def supplier_names
    self.suppliers.uniq.map(&:name)
  end

  def display_status
    if !offers.purchased.empty?
      text = "Awarded"
    else
      text = status
    end
  end

  def awarded?
    display_status.eql?("Awarded")
  end

  # FIXME : Reimplement
  def requote!
    duplicate_quote = self.dup

    self.requests.each do |request|
      duplicate_request = request.dup

      request.offers.each do |offer|
        duplicate_offer = offer.dup
        duplicate_offer.order_reference = nil
        duplicate_offer.request_id = nil

        duplicate_request.offers << duplicate_offer
      end

      duplicate_request.quote_id = nil
      duplicate_quote.requests << duplicate_request

    end

    duplicate_quote.save
    duplicate_quote
  end

  def compute_total_offered_prices
    offers.map(&:update_total_prices)
  end

end

# == Schema Information
#
# Table name: quotes
#
#  id                 :integer          not null, primary key
#  quote_date         :datetime
#  quote_reference    :string(255)
#  quantity           :float
#  description        :text
#  status             :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  client_id          :integer
#  supplier_id        :integer
#  order_id           :integer
#  signatory          :string(255)
#  signatory_position :string(255)
#  contact_person     :string(255)
#  remarks            :text
#  internal_notes     :text
#

