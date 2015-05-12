class TodayController < ApplicationController
  def show
    @quotes = Quote.today.decorate

  end
end
