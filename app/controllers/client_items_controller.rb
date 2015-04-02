class ClientItemsController < ApplicationController

  def index
    @client = Client.find(params[:client_id])
    @client_item_codes_arel = @client.requests.select(:item_code)
      .where.not(item_code: nil).where.not(item_code: '').uniq
      .page(params[:page]).per_page(15)
    @client_item_codes =  @client_item_codes_arel.collect(&:item_code)
  end

  def show
    @client = Client.find(params[:client_id])
    @item_code = params[:id]
    @requests = Request.where(item_code: @item_code).decorate

  end
end
