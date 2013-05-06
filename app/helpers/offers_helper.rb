module OffersHelper

  def offer_row_class(offer)
    case offer.display_status
    when "Delivered"
      'success'
    when "Ordered"
      'info'
    when "Not yet ordered"
      'error'
    end
  end
end
