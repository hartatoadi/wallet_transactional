class StockPricesController < ApplicationController
  def index
    client = LatestStockPrice::Client.new
    debugger
    @stock_prices = client.price_all
    render json: @stock_prices
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
end
