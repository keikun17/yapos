class Request < ActiveRecord::Base
  # attr_accessible :specs,
  #   :quantity,
  #   :unit,
  #   :remarks,
  #   :offers_attributes,
  #   :position,
  #   :item_code,
  #   :supplier_id # TODO : Remove unused column

  belongs_to :quote
  belongs_to :supplier, optional: true
  has_many :offers, dependent: :destroy

  has_many :suppliers, through: :offers
  has_many :orders, through: :offers

  accepts_nested_attributes_for :offers,
    :allow_destroy => true,
    :reject_if => lambda { |o| o[:specs].blank? &&
                          o[:price].blank?
  }
  delegate :name, :to => :supplier, :prefix => true, :allow_nil => true

  validates :specs, :presence => true

  default_scope -> { order('requests.position asc') }
  scope :pending_client_order, -> do
    where('requests.non_client_purchased_count > 0 and requests.client_purchased_count = 0').references(:requests)
  end

  scope :without_offers, -> do
    includes(:offers).where(offers: {id: nil})
  end

  scope :with_offers, -> do
    s = includes(:offers).where('offers.id is not null').references(:offers)
    s
  end

  scope :with_client_purchased_offers, -> do
    s.with_offers
    s = s.where('offers.order_reference is not nul').references(:offers)
    s
  end

  def service_offer_count
    offers.services.count
  end
end

# == Schema Information
#
# Table name: requests
#
#  id                         :integer          not null, primary key
#  specs                      :text(65535)
#  quote_id                   :integer
#  supplier_id                :integer
#  quoted_specifications      :text(65535)
#  remarks                    :text(65535)
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  quantity                   :float(24)
#  unit                       :string(255)
#  client_purchased_count     :integer          default(0)
#  non_client_purchased_count :integer          default(0)
#  position                   :integer
#  item_code                  :string(255)
#
