class VendorItem < ActiveRecord::Base
  belongs_to :product
  attr_accessible :code, :product_id, :product, :vendor_item_fields_attributes

  has_many :product_fields, through: :product
  has_many :vendor_item_fields
  has_many :product_fields, through: :vendor_item_fields
  has_many :offers
  has_many :quotes, through: :offers

  accepts_nested_attributes_for :vendor_item_fields, allow_destroy: true, :reject_if => lambda { |r| r[:value].blank? }

  # validates :code, presence: true, uniqueness: true
  validates :product_id, presence: true

  def self.initialize_fields(product)
    vendor_item = new(product: product)
    product.product_fields.each do |product_field|
      vendor_item.vendor_item_fields.build(product_field: product_field)
    end

    vendor_item
  end

  def self.find_or_initialize_fields_by(attributes, &block)
    vendor_item = find_or_initialize_by(attributes, &block)

    vendor_item.product.product_fields.each do |product_field|
      vendor_item.vendor_item_fields.build(product_field: product_field)
    end

    vendor_item
  end

  def self.find_or_create_with_initialized_fields_by(attributes, &block)
    vendor_item = find_or_initialize_fields_by(attributes, &block)
    vendor_item.save if !vendor_item.persisted?
    vendor_item
  end

  # 1. Update the record,
  # 2. When the `code` is changed, modify the offers' vendor_item_codes
  # to the new one and also update the Quotes
  def update_and_reindex_offers(vendor_item_params)
    affected_offers = self.offers.all
    affected_quotes = self.quotes.all

    if self.update(vendor_item_params)
      affected_offers.each do |offer|
        offer.update({vendor_item_code: self.code })
      end
      affected_quotes.uniq.map(&:reindex)
      true
    else
      false
    end
  end

  def self.find_with_fields(args)
    main_call = VendorItem.joins(:vendor_item_fields).references(:vendor_item_fields)

    arels = []

    args.each do |condition|
      if !condition[:vendor_item_fields][:value].blank?
        arels << main_call.where(condition)
      end
    end

    results = arels.reduce { |a, b| a & b }
    results
  end

  def self.find_with_exact_fields(args)

    arg_product_field_ids = args.collect do |arg|
      arg[:vendor_item_fields][:product_field_id]
    end

    results = find_with_fields(args).select do |x|
      x.product_field_ids == arg_product_field_ids
    end

    results

  end

end

# == Schema Information
#
# Table name: vendor_items
#
#  id         :integer          not null, primary key
#  code       :string(255)
#  product_id :integer
#  created_at :datetime
#  updated_at :datetime
#
