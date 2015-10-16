class GraphsController < ApplicationController

  def kanban
    @need_supplier_order = Quote.pending_supplier_order.decorate
    @for_scheduling = Quote.for_scheduling.decorate
    @manufacturing = Quote.manufacturing.decorate
    @for_delivery = Quote.for_delivery.decorate
  end

  def profits
    @sales = [
      { name: Time.now.year, data: MonthlyProfit.for(Time.now.year) },
      { name: 1.year.ago.year, data: align_chartkick_dates(MonthlyProfit.for(1.year.ago.year), 1) },
      { name: 2.years.ago.year, data: align_chartkick_dates(MonthlyProfit.for(2.years.ago.year), 2) },
    ]
  end

  def performance
    # QUOTES
    @quotes_count = Quote.where(created_at: [1.year.ago..Time.zone.now]).group_by_month(:created_at, time_zone: Time.zone).count
    @quotes_one_year_ago = Quote.where(created_at: [2.year.ago..1.year.ago.end_of_month]).group_by_month(:created_at, time_zone: Time.zone).count
    @quotes_two_years_ago = Quote.where(created_at: [3.year.ago..2.year.ago.end_of_month]).group_by_month(:created_at, time_zone: Time.zone).count

    @quotes_one_year_ago = align_chartkick_dates(@quotes_one_year_ago, 1)
    @quotes_two_years_ago = align_chartkick_dates(@quotes_two_years_ago, 2)

    @quote_dates = [
      {name: Time.now.year, data: @quotes_count},
      {name: 1.year.ago.year, data: @quotes_one_year_ago},
      {name: 2.years.ago.year, data: @quotes_two_years_ago}
    ]


    # ORDERS
    @orders_count = Order.where(created_at: [1.year.ago..Time.zone.now]).group_by_month(:created_at, time_zone: Time.zone).count
    @orders_one_year_ago = Order.where(created_at: [2.year.ago..1.year.ago.end_of_month]).group_by_month(:created_at, time_zone: Time.zone).count
    @orders_two_years_ago = Order.where(created_at: [3.year.ago..2.year.ago.end_of_month]).group_by_month(:created_at, time_zone: Time.zone).count

    @orders_one_year_ago = align_chartkick_dates(@orders_one_year_ago, 1)
    @orders_two_years_ago = align_chartkick_dates(@orders_two_years_ago, 2)

    @order_dates = [
      {name: Time.now.year, data: @orders_count},
      {name: 1.year.ago.year, data: @orders_one_year_ago},
      {name: 2.years.ago.year, data: @orders_two_years_ago},
    ]

  end

  private

  # Change the year to the current year so chartkick's plotted points will line
  # up
  #
  #  Arguments :
  #    date_hash  - hash - date hash format use by chartkick (keys are the date,
  #                        value is the count)
  #    offset     - int  - from how many years ago is the data in the date hash?
  def align_chartkick_dates(date_hash, offset)

    date_hash.keys.each do |date|
      new_date = Time.zone.at( date + offset.years).beginning_of_month

      # Rename the key
      date_hash[new_date] = date_hash.delete(date)
    end

    date_hash
  end

end
