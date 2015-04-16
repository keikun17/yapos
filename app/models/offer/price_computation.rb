class Offer
  module PriceComputation
    def total_currency_buying_price
      qty = request_quantity || 1
      (buying_price || 0) * qty
    end

    def total_currency_selling_price
      qty = request_quantity || 1
      (selling_price || 0) * qty
    end

    def update_total_prices
      # FIXME : We are not storing the conversion rate anymore. Let's do a
      # fixed currency conversion that can be set at an admin options level
      self.total_buying_price = compute_total_buying_price
      self.total_selling_price = compute_total_selling_price
      save
    end

    def conversion_rate
      if currency_conversion.present?
        currency_conversion
      else
        # FIXME : as per `update_total_prices` annotation, we  should pull
        # the conversion mapping at an admin control level
        Currency::CURRENCY_MAPPING[currency]
      end
    end

    private

    def compute_total_buying_price
      if currency == Currency::LOCAL_CURRENCY
        total_currency_buying_price
      elsif !currency.blank?
        total_currency_buying_price * conversion_rate if buying_price
      end
    end

    def compute_total_selling_price
      if currency == Currency::LOCAL_CURRENCY
        total_currency_selling_price
      elsif !currency.blank?
        total_currency_selling_price * conversion_rate if selling_price
      end
    end
  end
end
