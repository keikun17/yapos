class GraphsController < ApplicationController

  def kanban
    @need_supplier_order = Quote.pending_supplier_order.decorate
    @for_scheduling = Quote.for_scheduling.decorate
    @manufacturing = Quote.manufacturing.decorate
    @for_delivery = Quote.for_delivery.decorate
  end

  def performance
    @quotes_count = Quote.where(created_at: [1.year.ago..Time.zone.now]).group_by_week(:created_at, time_zone: Time.zone).count
    @prev_quotes_count = Quote.where(created_at: [2.year.ago..1.year.ago]).group_by_week(:created_at, time_zone: Time.zone).count
    @orders_count = Order.where(created_at: [1.year.ago..Time.zone.now]).group_by_week(:created_at, time_zone: Time.zone).count
    @prev_orders_count = Order.where(created_at: [2.year.ago..1.year.ago]).group_by_week(:created_at, time_zone: Time.zone).count
  end

end
