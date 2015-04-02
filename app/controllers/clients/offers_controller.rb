class Clients::OffersController  < ApplicationController

  respond_to :html, :json, :xml

  def index
    @client = Client.find(params[:client_id])
    @offers = @client.offers.order(created_at: :desc).page(params[:page]).per_page(50).decorate

    respond_with @offers

  end

end
