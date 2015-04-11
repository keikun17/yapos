class Offer < ActiveRecord::Base

  attr_accessible :request,
    :vendor_item_id,
    :supplier_id,
    :specs,
    :summary,
    :buying_price,
    :selling_price,
    :buying_currency,
    :currency,
    :currency_conversion,
    :price_vat_status,
    :order_reference,
    :remarks,
    :terms,
    :delivery,
    :warranty,
    :supplier_order_attributes,
    :total_buying_price,
    :total_selling_price,
    :price_basis,
    :delivery_receipt_reference,
    :sales_invoice_reference,
    :vendor_item_code,
    :hide_supplier_in_print,
    :internal_notes,
    :service

  belongs_to :request

  counter_culture :request, column_name: Proc.new {|model|
    "#{model.client_purchased_status}_count"
  }, :column_names => {
    ["offers.order_reference <> ''"] => 'client_purchased_count',
    ["offers.order_reference = '' or offers.order_reference is null"] => 'non_client_purchased_count'
  }

  belongs_to :supplier
  belongs_to :vendor_item
  belongs_to :order,
    :primary_key => 'reference',
    :foreign_key => 'order_reference'

  has_one :quote, :through => :request
  has_one :supplier_order, inverse_of: :offer, dependent: :destroy
  has_one :supplier_purchase, :through => :supplier_order
  has_one :client, :through => :quote

  accepts_nested_attributes_for :supplier_order

  scope :purchased, -> { where("order_reference <> '' ") }
  scope :supplier_hidden_in_print, -> { where(hide_supplier_in_print: true) }
  scope :services, -> { where(service: true) }
  scope :supplies, -> { where.not(service: true) }

  scope :from_supplier, ->(suppliers = 'all') do
    if suppliers.eql?('all')
      s = where('supplier_id is not null')
    else
      supplier_ids = suppliers.map(&:id)
      s = where(supplier_id: supplier_ids)
    end
    s
  end

  scope :pending_client_order, -> {
    # (1) This :
    # includes(request: :orders).where(orders: {id: nil}).references(:request, :orders)

    # (2) Or This way :
    # where("offers.order_reference = '' or offers.order_reference is null")

    # (3) Or this way :
    includes({request: :orders}).where(requests: {client_purchased_count: 0} ).references(:requests)
  }

  scope :pending_supplier_order, -> do
    s = purchased.includes(:supplier_order).references(:supplier_orders)
    s = s.where('supplier_orders.reference is null')
    s
  end

  scope :by_quote_date, -> do
    includes(:quote).references(:quotes).order("quotes.quote_date desc")
  end
  scope :by_supplier_order_date, -> do
    includes(supplier_order: :supplier_purchase).references(:supplier_orders, :supplier_purchases).order("supplier_purchases.ordered_at is null desc").order("supplier_purchases.ordered_at desc")
  end

  # Client Delegation
  delegate :name, to: :client, prefix: true, allow_nil: true

  # Supplier Delegation
  delegate :name, to: :supplier, prefix: true, allow_nil: true
  delegate :address, to: :supplier, prefix: true, allow_nil: true
  delegate :reference, to: :supplier_purchase, prefix: true, allow_nil: true

  # Request Delegation
  delegate :quantity,
    :unit,
    :specs, :to => :request, :prefix => true, :allow_nil => true

  # Quote Delegation
  delegate :quote_reference, to: :quote, prefix: false, allow_nil: true
  delegate :quote_date, to: :quote, prefix: false, allow_nil: true

  # Vendor Item Delegation
  delegate :csv, to: :vendor_item, prefix: true, allow_nil: true

  # Supplier Order Delegation
  delegate :reference,
    :ordered_at,
    :estimated_manufactured_at,
    :estimated_manufacture_date,
    :estimated_delivered_at,
    :estimated_delivery_date,
    :delivered_at,
    :delivery_date,
    :delivered?,
    :actual_specs,
    :ordered_from_supplier?, to: :supplier_order, prefix: true, allow_nil: true

  delegate :ordered_at, :order_date, to: :supplier_purchase, allow_nil: true, prefix: true

  def supply?
    !self.service?
  end

  def client_ordered?
    !self.order_reference.blank?
  end

  def client_purchased_status
    if self.order_reference.blank?
      'non_client_purchased'
    else
      'client_purchased'
    end
  end

  def purchase_from_supplier_if_needed
    if !supplier_order.nil? or !supplier_order_reference.blank?
      SupplierPurchase.find_or_create_by(reference: self.supplier_order.reference)
    end
  end

  def total_currency_buying_price
    qty = self.request_quantity || 1
    (self.buying_price || 0) * qty
  end

  def total_currency_selling_price
    qty = self.request_quantity || 1
    (self.selling_price || 0) * qty
  end

  def update_total_prices
    # FIXME : We are not storing the conversion rate anymore. Let's do a
    # fixed currency conversion that can be set at an admin options level
    if self.currency == Currency::LOCAL_CURRENCY
      (self.total_buying_price = total_currency_buying_price) if buying_price
      (self.total_selling_price = total_currency_selling_price) if selling_price

    elsif !self.currency.blank?

      conversion_rate = if conversion_rate.blank?
                          Currency::CURRENCY_MAPPING[currency]
                        else
                          self.conversion_rate
                        end

      if buying_price
        self.total_buying_price = total_currency_buying_price * conversion_rate

      end

      if selling_price
        self.total_selling_price = total_currency_selling_price * conversion_rate
      end

    else
      0
    end

    save
  end
end

# == Schema Information
#
# Table name: offers
#
#  id                         :integer          not null, primary key
#  request_id                 :integer
#  supplier_id                :integer
#  specs                      :text
#  buying_price               :float(24)
#  selling_price              :float(24)
#  currency                   :string(255)
#  currency_conversion        :float(24)
#  order_reference            :string(255)
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  remarks                    :text
#  terms                      :string(255)
#  delivery                   :string(255)
#  warranty                   :string(255)
#  price_vat_status           :string(255)
#  total_buying_price         :float(24)
#  total_selling_price        :float(24)
#  price_basis                :string(255)
#  summary                    :string(255)
#  delivery_receipt_reference :string(255)
#  sales_invoice_reference    :string(255)
#  vendor_item_code           :string(255)
#  vendor_item_id             :string(255)
#  hide_supplier_in_print     :boolean
#  internal_notes             :text
#  buying_currency            :string(255)
#  service                    :boolean          default(FALSE)
#
