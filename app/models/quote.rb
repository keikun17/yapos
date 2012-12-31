class Quote < ActiveRecord::Base
  attr_accessible :description,
    :quantity,
    :quote_date,
    :quote_reference,
    :requester,
    :status,
    :client_id

  belongs_to :client

  delegate :name, :to => :client, :allow_nil => true, :prefix => true
end
