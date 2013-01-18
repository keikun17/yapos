class Quote < ActiveRecord::Base
  attr_accessible :description,
    :quantity,
    :quote_date,
    :quote_reference,
    :status,
    :client_id,
    :supplier_id,
    :order_id,
    :requests_attributes,
    :attachments_attributes

  has_many :requests
  has_many :suppliers, :through => :requests
  has_many :attachments, :as => :attachable

  accepts_nested_attributes_for :attachments, :allow_destroy => true,
    :reject_if => lambda { |a| a[:document].nil? }

  accepts_nested_attributes_for :requests, :allow_destroy => true, 
    :reject_if => lambda { |r| r[:supplier].nil? &&
                           r[:requested_specifications].blank? &&
                           r[:quoted_specifications].blank? && 
                           r[:remarks].blank?  }

  belongs_to :client
  belongs_to :order
  belongs_to :supplier

  delegate :reference, :to => :order, :allow_nil => true, :prefix => true
  delegate :name, :to => :client, :allow_nil => true, :prefix => true
  delegate :name, :to => :supplier, :allow_nil => true, :prefix => true

  scope :unawarded, where(:order_id => nil)
  default_scope order('quote_date desc')

  def display_status
    if order.present?
      "Awarded"
    else
      status
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
