class GraphsController < ApplicationController

  def kanban
    @need_supplier_order = Quote.pending_supplier_order.decorate
    @for_scheduling = Quote.for_scheduling.decorate
    @manufacturing = Quote.manufacturing.decorate
    @for_delivery = Quote.for_delivery.decorate
  end

  def performance
    @quotes_count = Quote.where(created_at: [1.year.ago..Time.zone.now]).group_by_month(:created_at, time_zone: Time.zone).count

    @prev_quotes_count = Quote.where(created_at: [2.year.ago..1.year.ago]).group_by_month(:created_at, time_zone: Time.zone).count

    @x = @prev_quotes_coun
    @prev_quotes_count.keys.each do |date|
      new_date = Time.zone.at( date + 1.year).beginning_of_month

      # Rename the key
      @prev_quotes_count[new_date] = @prev_quotes_count.delete(date)
    end

    @orders_count = Order.where(created_at: [1.year.ago..Time.zone.now]).group_by_month(:created_at, time_zone: Time.zone).count
    @prev_orders_count = Order.where(created_at: [2.year.ago..1.year.ago]).group_by_month(:created_at, time_zone: Time.zone).count

    @prev_orders_count.keys.each do |date|
      new_date = Time.zone.at( date + 1.year).beginning_of_month

      # Rename the key
      @prev_orders_count[new_date] = @prev_orders_count.delete(date)
    end
  end

end
