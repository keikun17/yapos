class KanbanController < ApplicationController	
	
  def show
    @need_supplier_order = Quote.pending_supplier_order
    @for_scheduling = Quote.for_scheduling
    @manufacturing = Quote.manufacturing
    @for_delivery = Quote.for_delivery
  end

end