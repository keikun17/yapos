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
    :remarks

  has_many :attachments, :as => :attachable
  has_many :requests, dependent: :destroy
  has_many :offers, :through => :requests 

  has_many :suppliers, :through => :offers
  has_many :orders, :through => :offers

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

  scope :unawarded, where(:order_id => nil)
  default_scope order('quote_date desc, id desc')

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

  def supplier_names
    s = self.suppliers.map(&:name)
    s << self.supplier_name
    s = s.uniq.compact
    s
  end

  def display_status
    if !offers.purchased.empty?
      text = "Awarded"
    else
      text = status
    end
  end

  def requote!
    clone_attrs = self.attributes.symbolize_keys
    clone_attrs.delete(:created_at)
    clone_attrs.delete(:id)
    clone_attrs.delete(:updated_at)
    clone_attrs.delete(:order_id)

    repeat_order = self.class.new(clone_attrs)
    repeat_order.quote_reference = repeat_order.quote_reference + "-" + Date.today.strftime('%Y%m%d') 
    repeat_order.save
    repeat_order
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
#

