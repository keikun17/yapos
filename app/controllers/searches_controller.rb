class SearchesController < ApplicationController

  def search
    @results = Quote.search(params[:search][:string])
    @results = SearchResult.decorate_collection(@results)
  end

end
