class Requoter
  def self.requote(quote)
    duplicate_quote = quote.dup
    internal_note = "Based on previous RFQ: #{quote.quote_reference}\r\n"
    duplicate_quote.internal_notes = internal_note

    duplicate_quote.quote_reference = quote.quote_reference + "-requote"

    quote.requests.each do |request|
      duplicate_request = request.dup

      request.offers.each do |offer|
        duplicate_offer = offer.dup
        duplicate_offer.request_id = nil
        duplicate_offer.delivery_receipt_reference = nil
        duplicate_offer.sales_invoice_reference = nil

        if offer.order.present?
          internal_note = "Based on previous client order: #{offer.order_reference}\r\n"
          duplicate_offer.internal_notes = duplicate_offer.internal_notes.prepend(internal_note)
        end

        if offer.supplier_purchase.present?
          internal_note = "Based on previous supplier purchase: #{offer.supplier_order.supplier_purchase.reference}\r\n"
          duplicate_offer.internal_notes = duplicate_offer.internal_notes.prepend(internal_note)
        end

        duplicate_offer.order_reference = nil

        duplicate_request.offers << duplicate_offer
      end

      duplicate_request.quote_id = nil
      duplicate_quote.requests << duplicate_request
    end

    duplicate_quote.status = "Pending"
    duplicate_quote.quote_date = Time.zone.now
    duplicate_quote.save
    duplicate_quote
  end
end
