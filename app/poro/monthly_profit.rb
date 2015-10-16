class MonthlyProfit

  # Return a hash of earnings for the year. Hash keys are Dates (start of month)
  # and the value is the total earnings for the entire month
  #
  # Arguments:
  #   year         - integer                   - Year
  #   for_services - boolean (default: false)  - Whether to filter only services. defaults to 'false' that returns only supply sales
  def self.for(year, for_services = false)
    expenses = monthly_expenses_for(year, for_services)
    sales = monthly_sales_for(year, for_services)

    profit = {}

    sales.each do |k,v|
      profit[k] = (sales[k] - expenses[k]).to_f

    end

    profit
  end

  private

  def self.monthly_sales_for(year, for_services = false)
    offset = Time.now.year - year
    date = Time.zone.at( Time.now - offset.years ).beginning_of_year
    start_of_year = date.beginning_of_year
    end_of_year = date.end_of_year

    supply_sales = Offer.purchased.where(
      currency:  Currency::LOCAL_CURRENCY,
      buying_currency: Currency::LOCAL_CURRENCY,
      service: for_services,
      created_at: [start_of_year..end_of_year]
    ).group_by_month(:created_at, time_zone: Time.zone).sum(:selling_price)
  end

  def self.monthly_expenses_for(year, for_services = false)
    offset = Time.now.year - year
    date = Time.zone.at( Time.now - offset.years ).beginning_of_year
    start_of_year = date.beginning_of_year
    end_of_year = date.end_of_year

    supply_sales = Offer.purchased.where(
      currency:  Currency::LOCAL_CURRENCY,
      buying_currency: Currency::LOCAL_CURRENCY,
      service: for_services,
      created_at: [start_of_year..end_of_year]
    ).group_by_month(:created_at, time_zone: Time.zone).sum(:buying_price)
  end

end

