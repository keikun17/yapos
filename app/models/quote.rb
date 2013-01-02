class Quote < ActiveRecord::Base
  attr_accessible :description,
    :quantity,
    :quote_date,
    :quote_reference,
    :status,
    :client_id,
    :supplier_id,
    :order_id

  belongs_to :client
  belongs_to :order
  belongs_to :supplier

  delegate :reference, :to => :order, :allow_nil => true, :prefix => true
  delegate :name, :to => :client, :allow_nil => true, :prefix => true
  delegate :name, :to => :supplier, :allow_nil => true, :prefix => true

  scope :unawarded, where(:order_id => nil)

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
