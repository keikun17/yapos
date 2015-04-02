class StocksController < ApplicationController

  def index
    @stocks = Stock.all.page(params[:page])
  end

  def show
    @stock = Stock.find(params[:id])
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
    @stock = Stock.find(params[:id])
  end

  def update
    @stock = Stock.find(params[:id])
    if @stock.update_attributes(params[:stock])
      redirect_to stocks_path
    else
      render 'edit'
    end
  end


end
