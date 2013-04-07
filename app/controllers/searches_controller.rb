class SearchesController < ApplicationController
  def search
    params[:search] ||= {}
    # valid_states = ['Pending', 'Cancelled', 'No Quote', 'Awarded']
    @results = Quote.where(:status => params[:search][:state]).paginate(:page => params[:page], :per_page => 10)
    @results = Quote.search(params[:search])
    binding.pry
  end

end
