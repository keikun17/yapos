class SearchesController < ApplicationController

  def search
    @results = SearchResult.retrieve(Quote, params[:search])
  end

end
