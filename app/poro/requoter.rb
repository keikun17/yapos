class Requoter

  def self.requote(quote)
    duplicate_quote = quote.dup

    # Set reference RFQ to the internal notes
    internal_note = "Based on previous RFQ: #{quote.quote_reference}\r\n"
    duplicate_quote ||= ""
    duplicate_quote.internal_notes = duplicate_quote.internal_notes.prepend(internal_note)

    # Initial RFQ name is the sournce refernece + 'requote'
    duplicate_quote.quote_reference = quote.quote_reference + "-requote"

    # Reset RFQ state
    duplicate_quote.status = "Pending"
    duplicate_quote.quote_date = Time.zone.now

    # Duplicate the request and offers
    duplicate_quote.requests = duplicate_quote_requests_and_offers(quote: quote)

    duplicate_quote.save
    duplicate_quote
  end

  private

  def self.duplicate_quote_requests_and_offers(quote:)
    duplicate_requests = []

    quote.requests.each do |request|
      duplicate_request = request.dup

      duplicate_request.offers = duplicate_request_offers(request: request)

      duplicate_request.quote_id = nil
      duplicate_requests << duplicate_request
    end

    duplicate_requests
  end

  def self.duplicate_request_offers(request:)
    duplicate_offers = []

    request.offers.each do |offer|
      duplicate_offer = offer.dup
      duplicate_offer.request_id = nil
      duplicate_offer.delivery_receipt_reference = nil
      duplicate_offer.sales_invoice_reference = nil

      if offer.order.present?
        duplicate_offer.internal_notes ||= ""
        internal_note = "Based on previous client order: #{offer.order_reference}\r\n"
        duplicate_offer.internal_notes = duplicate_offer.internal_notes.prepend(internal_note)
      end

      if offer.supplier_purchase.present?
        duplicate_offer.internal_notes ||= ""
        internal_note = "Based on previous supplier purchase: #{offer.supplier_order.supplier_purchase.reference}\r\n"
        duplicate_offer.internal_notes = duplicate_offer.internal_notes.prepend(internal_note)
      end

      duplicate_offer.order_reference = nil

      duplicate_offers << duplicate_offer
    end
    duplicate_offers
  end
end
