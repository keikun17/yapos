class ClientItemsController < ApplicationController

  def index
    @requests = Request.where.not(item_code: nil).uniq.paginate(page: params[:per_page])
  end
end
