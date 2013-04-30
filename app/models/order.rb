class Order < ActiveRecord::Base
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

  validates_presence_of :reference
  validates_associated :attachments

  accepts_nested_attributes_for :quotes
  accepts_nested_attributes_for :offers
  accepts_nested_attributes_for :attachments,
    :allow_destroy => true,
    :reject_if => lambda { |a| a[:document].nil? }

  default_scope order('purchase_date is null desc, purchase_date desc')

  def clear_quotes
    self.quotes.update_all(:order_id => nil)
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

