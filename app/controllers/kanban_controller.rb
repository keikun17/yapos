class KanbanController < ApplicationController	
	
  def show
    @need_supplier_order = Quote.pending_supplier_order.decorate
    @for_scheduling = Quote.for_scheduling.decorate
    @manufacturing = Quote.manufacturing.decorate
    @for_delivery = Quote.for_delivery.decorate
  end

  def quotes
    @quotes_count = Quote.where(created_at: [1.year.ago..Time.zone.now]).group_by_day(:created_at, time_zone: Time.zone).count
  end

  def orders
    @orders_count = Order.where(created_at: [1.year.ago..Time.zone.now]).group_by_day(:created_at, time_zone: Time.zone).count
  end

  def all
    @quotes_count = Quote.where(created_at: [1.year.ago..Time.zone.now]).group_by_day(:created_at, time_zone: Time.zone).count
    @orders_count = Order.where(created_at: [1.year.ago..Time.zone.now]).group_by_day(:created_at, time_zone: Time.zone).count
  end

end
