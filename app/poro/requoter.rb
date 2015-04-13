class Requoter
  def self.requote(quote)
    duplicate_quote = quote.dup
    duplicate_quote.quote_reference = quote.quote_reference + "-requote"

    quote.requests.each do |request|
      duplicate_request = request.dup

      request.offers.each do |offer|
        duplicate_offer = offer.dup
        duplicate_offer.order_reference = nil
        duplicate_offer.request_id = nil
        duplicate_offer.delivery_receipt_reference = nil
        duplicate_offer.sales_invoice_reference = nil

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
