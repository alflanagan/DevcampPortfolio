class PortfoliosController < ApplicationController

  def index
    @items = Portfolio.all
  end
end
