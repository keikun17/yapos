class Clients::OffersController  < ApplicationController

  def index
    @client = Client.find(params[:client_id])
    @offers = @client.offers.paginate(per_page: 50, page: params[:page])
    @decorated_offers = OfferDecorator.decorate_collection(@offers)
  end

end
