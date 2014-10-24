class KanbanController < ApplicationController	
	
  def show
    @need_supplier_order = Quote.pending_supplier_order.decorate
    @for_scheduling = Quote.for_scheduling.decorate
    @manufacturing = Quote.manufacturing.decorate
    @for_delivery = Quote.for_delivery.decorate
  end

end
