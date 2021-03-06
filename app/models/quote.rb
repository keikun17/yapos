class Quote < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  acts_as_commentable

  has_many :comment_threads, :class_name => "QuoteComment", :as => :commentable

  attr_accessible :title,
    # :description, #TODO : Remove 'description' column. it has no valid use
    # case anymore
    :blurb,
    :signatory,
    :signatory_position,
    :contact_person,
    :quantity,
    :quote_date,
    :quote_reference,
    :supplier_id, #TODO : Remove supplier ID because we reference the supplier from the offer
    # :status, # TODO : Remove 'status' column. we have no use for this anymore.
    #                   the 'cancelled' status should just be a check box
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
  validates :quote_reference, presence: true, uniqueness: true

  accepts_nested_attributes_for :attachments,
    :allow_destroy => true,
    :reject_if => lambda { |a| a[:document].nil? }

  accepts_nested_attributes_for :requests,
    :allow_destroy => true,
    :reject_if => lambda { |r| r[:supplier].nil? && r[:specs].blank? && r[:remarks].blank?  }

  belongs_to :client
  belongs_to :supplier

  delegate :reference, :to => :order, :allow_nil => true, :prefix => true
  delegate :name, :to => :supplier, :allow_nil => true, :prefix => true

  # Concerns
  include ClientDelegation

  scope :unawarded, -> { where(:order_id => nil) }
  scope :not_closed, -> { where("quotes.status not in ('Cancelled', 'No Quote', 'Not Awarded')") }

  scope :with_pending_requests, -> do
    not_closed.includes(:offers).where(offers: {request_id: nil})
  end

  default_scope { order("quotes.quote_date desc, quotes.id desc") }

  def self.pending_client_order
    not_closed.includes(:requests).merge(Request.pending_client_order)
  end

  def self.pending_supplier_order
    s = not_closed.includes([:supplier_orders, :offers]).references(:supplier_orders, :offers)

    # Where the Supplier order has no Supplier PO Reference
    s = s.where("supplier_orders.reference = '' or supplier_orders.reference is null")

    # Quotes that at least has at least 1 client ordered offer
    s = s.where("offers.id is not null").where("offers.order_reference <> ''")

    # s = s.where("offers.order_reference <> ''")
    s
  end

  # Quotes that needs to be have the ex-works date set
  def self.for_scheduling
    not_closed.includes(:supplier_orders).references(:supplier_orders)
      .where("supplier_orders.reference != '' or supplier_orders.reference is not null")
      .where("supplier_orders.estimated_manufactured_at is null")
      .where("supplier_orders.delivered_at is null")
  end

  def self.manufacturing
    not_closed.includes(:supplier_orders).references(:supplier_orders)
      .where("supplier_orders.reference != '' or supplier_orders.reference is not null")
      .where("'#{Time.zone.now.to_s(:db)}' < supplier_orders.estimated_manufactured_at")
      .where("supplier_orders.delivered_at is null")
  end

  def self.for_delivery
    not_closed.includes(:supplier_orders).references(:supplier_orders)
      .where("'#{Time.zone.now.to_s(:db)}' >= supplier_orders.estimated_manufactured_at")
      .where("supplier_orders.delivered_at is null")
  end

  def self.today
    quotes = Quote.arel_table
    created_today = quotes[:created_at].in(Time.zone.today.beginning_of_day..Time.zone.today.end_of_day)
    quoted_today = quotes[:quote_date].in(Time.zone.today.beginning_of_day..Time.zone.today.end_of_day)
    Quote.where(created_today.or(quoted_today))
  end

  # Tire/ElasticSearch Configuration
  def as_indexed_json(options = {})
    as_json(
      only: [
        :title, :blurb, :quote_reference, :display_status,
        :description, :quote_date
      ],

      # Associations
      include: {
        client: {
          only: [:name, :abbrev]
        },
        requests: {
          only: [:quantity, :unit, :specs, :item_code]
        },

        # Offers Association
        offers: {
          methods: [:supplier_name],
          only: [
            :specs, :vendor_item_code, :summary,

            # Repeat the `methods`
            :supplier_name
          ]
        }
      }
    )
  end

  def reindex
    __elasticsearch__.index_document
  end

  # /-- Tire/ElasticSearch config

  def request_specs
    requests.map(&:specs).uniq.compact
  end

  def supplier_po
    "implement"
  end

  def offered_specs
    offers.pluck(:specs).uniq
  end

  def offer_summaries
    offers.pluck(:summary).uniq
  end

  def supplier_names
    suppliers.pluck(:name).uniq
  end

  def display_status
    if orders.present?
      "Awarded"
    else
      status
    end
  end

  def awarded?
    display_status.eql?("Awarded")
  end

  # FIXME : Reimplement
  def requote!
    Requoter.requote(self)
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
#  quantity           :float(24)
#  description        :text(65535)
#  status             :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  client_id          :integer
#  supplier_id        :integer
#  order_id           :integer
#  signatory          :string(255)
#  signatory_position :string(255)
#  contact_person     :string(255)
#  remarks            :text(65535)
#  internal_notes     :text(65535)
#  title              :text(65535)
#  blurb              :text(65535)
#
