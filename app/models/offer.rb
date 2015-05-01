class Offer < ActiveRecord::Base
  include Offer::PriceComputation

  attr_accessible(
    :request,
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
    :invoices_attributes,
    :total_buying_price,
    :total_selling_price,
    :price_basis,
    :delivery_receipt_reference,
    :sales_invoice_reference, # TODO Mark for deletion, Invoice model implemented
    :vendor_item_code,
    :hide_supplier_in_print,
    :internal_notes,
    :service
  )

  # TODO : Prevent duplicate associations
  def invoices_attributes=(things)
    _invoices = []

    things.each do |k,v|
      marked_for_deletion = (!v["_destroy"].nil? and (v.delete("_destroy") != 'false'))
      invoice = Invoice.find_or_create_by(reference: v["reference"])

      if marked_for_deletion
        self.invoices.delete(invoice)

      else
        _invoices << invoice unless invoice.reference.blank?
      end

    end

    self.invoices = _invoices

  end

  belongs_to :request

  counter_culture(
    :request,
    column_name: proc { |model| "#{model.client_purchased_status}_count" },
    column_names:  {
      ["offers.order_reference <> ''"] => "client_purchased_count",
      ["offers.order_reference = '' or offers.order_reference is null"] => "non_client_purchased_count"
    }
  )

  belongs_to :supplier
  belongs_to :vendor_item
  belongs_to :order, primary_key: "reference", foreign_key: "order_reference"

  has_one :quote, through: :request
  has_one :supplier_order, inverse_of: :offer, dependent: :destroy
  has_one :supplier_purchase, through: :supplier_order
  has_one :client, through: :quote

  has_many :offers_invoices, dependent: :destroy
  has_many :invoices, through: :offers_invoices

  accepts_nested_attributes_for :supplier_order

  accepts_nested_attributes_for :invoices,
    :allow_destroy => true,
    :reject_if => lambda { |i| i[:reference].blank? }

  scope :purchased, -> { where("order_reference <> '' ") }
  scope :supplier_hidden_in_print, -> { where(hide_supplier_in_print: true) }
  scope :services, -> { where(service: true) }
  scope :supplies, -> { where.not(service: true) }

  scope :pending_client_order, (lambda do
    # (3) Or this way :
    # This checks if there are sibling offers that belong to the same request
    # that is already purchased.
    includes(request: :orders).where(requests: { client_purchased_count: 0 }).references(:requests)
  end)

  scope :pending_supplier_order, (lambda do
    purchased.includes(:supplier_order)
      .references(:supplier_orders)
      .where(supplier_orders: { reference: nil })
  end)

  scope :by_quote_date, (lambda do
    includes(:quote).references(:quotes)
      .order('quotes.quote_date desc')
  end)

  scope :by_supplier_order_date, (lambda do
    includes(supplier_order: :supplier_purchase)
      .references(:supplier_orders, :supplier_purchases)
      .order("supplier_purchases.ordered_at is null desc").order("supplier_purchases.ordered_at desc")
  end)

  # Client Delegation
  delegate :name, to: :client, prefix: true, allow_nil: true

  # Supplier Delegation
  delegate :name, :address, to: :supplier, prefix: true, allow_nil: true

  delegate :reference, to: :supplier_purchase, prefix: true, allow_nil: true

  # Request Delegation
  delegate(
    :quantity,
    :unit,
    :specs,
    to: :request, prefix: true, allow_nil: true
  )

  # Quote Delegation
  delegate :quote_reference, :quote_date, to: :quote, prefix: false, allow_nil: true

  # Vendor Item Delegation
  delegate :csv, to: :vendor_item, prefix: true, allow_nil: true

  # Supplier Order Delegation
  delegate(
    :reference,
    :ordered_at,
    :estimated_manufactured_at,
    :estimated_manufacture_date,
    :estimated_delivered_at,
    :estimated_delivery_date,
    :delivered_at,
    :delivery_date,
    :delivered?,
    :actual_specs,
    :ordered_from_supplier?,
    to: :supplier_order, prefix: true, allow_nil: true
  )

  delegate :ordered_at, :order_date, to: :supplier_purchase, allow_nil: true, prefix: true

  def self.from_supplier(suppliers)
    suppliers ||= 'all'
    if suppliers.eql?("all")
      where.not(supplier_id: nil)
    else
      supplier_ids = suppliers.map(&:id)
      where(supplier_id: supplier_ids)
    end
  end

  def supply?
    !self.service?
  end

  def client_ordered?
    !order_reference.blank?
  end


  # FIXME : We do not need this method and any calls to this method. We should
  # instead guarantee that a SupplierPurchase record is made everytime a
  # Supplier PO refernce is supplied on the supplier order record.
  def purchase_from_supplier_if_needed
    if supplier_order.present? && supplier_purchase.nil?
      SupplierPurchase.find_or_create_by(reference: supplier_order.reference)
    end
  end

  def client_purchased_status
    if order_reference.blank?
      "non_client_purchased"
    else
      "client_purchased"
    end
  end

end

# == Schema Information
#
# Table name: offers
#
#  id                         :integer          not null, primary key
#  request_id                 :integer
#  supplier_id                :integer
#  specs                      :text(65535)
#  buying_price               :decimal(15, 2)
#  selling_price              :decimal(15, 2)
#  currency                   :string(255)
#  currency_conversion        :float(24)
#  order_reference            :string(255)
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  remarks                    :text(65535)
#  terms                      :string(255)
#  delivery                   :string(255)
#  warranty                   :string(255)
#  price_vat_status           :string(255)
#  total_buying_price         :decimal(15, 2)
#  total_selling_price        :decimal(15, 2)
#  price_basis                :string(255)
#  summary                    :string(255)
#  delivery_receipt_reference :string(255)
#  sales_invoice_reference    :string(255)
#  vendor_item_code           :string(255)
#  vendor_item_id             :string(255)
#  hide_supplier_in_print     :boolean
#  internal_notes             :text(65535)
#  buying_currency            :string(255)
#  service                    :boolean          default(FALSE)
#
