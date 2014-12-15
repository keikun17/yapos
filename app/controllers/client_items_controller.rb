class ClientItemsController < ApplicationController

  def index
    @client_item_codes = Request.select(:item_code).where.not(item_code: nil).where.not(item_code: '').uniq.paginate(page: params[:per_page])
    # @client_item_codes = Request.uniq.pluck(:item_code).paginate(page: params[:per_page])
    @client_item_codes =  @client_item_codes.collect(&:item_code).uniq
  end
end
