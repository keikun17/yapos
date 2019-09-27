class IncomeReport

  require 'action_view'

  def self.for_month(month)


    current_date = Time.now
    current_year = current_date.year

    three_years_ago = current_year - 3
    two_years_ago = current_year - 2
    last_year = current_year - 1
    this_year = current_year


    three_years_ago_start = DateTime.new(three_years_ago, month, 1)
    three_years_ago_end = three_years_ago_start.end_of_month

    two_years_ago_start = DateTime.new(two_years_ago, month, 1)
    two_years_ago_end = two_years_ago_start.end_of_month

    last_year_start = DateTime.new(last_year, month, 1)
    last_year_end = last_year_start.end_of_month

    this_year_start = DateTime.new(current_year, month, 1)
    this_year_end = this_year_start.end_of_month

    report = {}

    sales_three_years_ago  = Offer.includes(:order).references(:orders).where(orders: { purchase_date: three_years_ago_start..three_years_ago_end }).sum(:total_selling_price)
    sales_two_years_ago = Offer.includes(:order).references(:orders).where(orders: { purchase_date: two_years_ago_start..two_years_ago_end }).sum(:total_selling_price)
    sales_last_year =  Offer.includes(:order).references(:orders).where(orders: {purchase_date: last_year_start..last_year_end }).sum(:total_selling_price)
    sales_this_year = Offer.includes(:order).references(:orders).where(orders: {purchase_date: this_year_start..this_year_end }).sum(:total_selling_price)

    purchases_three_years_ago  = Offer.includes(:order).references(:orders).where(orders: { purchase_date: three_years_ago_start..three_years_ago_end }).sum(:total_buying_price)
    purchases_two_years_ago = Offer.includes(:order).references(:orders).where(orders: { purchase_date: two_years_ago_start..two_years_ago_end }).sum(:total_buying_price)
    purchases_last_year =  Offer.includes(:order).references(:orders).where(orders: {purchase_date: last_year_start..last_year_end }).sum(:total_buying_price)
    purchases_this_year = Offer.includes(:order).references(:orders).where(orders: {purchase_date: this_year_start..this_year_end }).sum(:total_buying_price)

    helper = ActionView::Base.new

    report[three_years_ago] = helper.number_to_currency(sales_three_years_ago.to_f - purchases_three_years_ago.to_f)
    report[two_years_ago] = helper.number_to_currency(sales_two_years_ago.to_f - purchases_two_years_ago.to_f)
    report[last_year] = helper.number_to_currency(sales_last_year.to_f - purchases_last_year.to_f)
    report[this_year] = helper.number_to_currency(sales_this_year.to_f - purchases_this_year.to_f)

    return report

  end

  def for_year(year)

  end
end
