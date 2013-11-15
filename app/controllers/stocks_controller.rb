class StocksController < ApplicationController

  def index
    @stocks = Stock.all.paginate(page: params[:page])
  end

  def show
  end

  def new
    @stock = Stock.new
  end

  def create
    @stock = Stock.new(params[:stock])

    if @stock.save
      redirect_to stocks_path
    else
      render 'new'
    end

  end

  def edit
  end

  def update
  end


end
