class Quote < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  attr_accessible :description,
    :quantity,
    :quote_date,
    :quote_reference,
    :supplier_id, 
    :status,
    :client_id,
    :order_id,
    :requests_attributes,
    :attachments_attributes

  has_many :requests
  has_many :suppliers, :through => :requests
  has_many :attachments, :as => :attachable

  accepts_nested_attributes_for :attachments,
    :allow_destroy => true,
    :reject_if => lambda { |a| a[:document].nil? }

  accepts_nested_attributes_for :requests,
    :allow_destroy => true, 
    :reject_if => lambda { |r| r[:supplier].nil? &&
                           r[:specs].blank? &&
                           r[:remarks].blank?  }

  belongs_to :client
  belongs_to :order
  belongs_to :supplier

  delegate :reference, :to => :order, :allow_nil => true, :prefix => true
  delegate :name, :to => :client, :allow_nil => true, :prefix => true
  delegate :name, :to => :supplier, :allow_nil => true, :prefix => true

  scope :unawarded, where(:order_id => nil)
  default_scope order('quote_date desc')

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
      quote_date: quote_date
    }.to_json
  end

  # /-- Tire/ElasticSearch config

  def request_specs
    r = requests.map(&:specs)
    r = r.uniq.compact
  end

  def supplier_names
    s = self.suppliers.map(&:name)
    s << self.supplier_name
    s = s.uniq.compact
    s
  end

  def display_status
    if order.present?
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

end
