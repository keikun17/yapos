class Clients::OffersController  < ApplicationController

  respond_to :html, :json, :xml

  def index
    @client = Client.find(params[:client_id])
    @offers = @client.offers.order(created_at: :desc).paginate(per_page: 50, page: params[:page]).decorate

    respond_with @offers

  end

end
