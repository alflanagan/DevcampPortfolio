class PortfoliosController < ApplicationController

  def index
    @items = Portfolio.all
  end

  def new
    @item = Portfolio.new
  end

  def create
    @item = Portfolio.new(params.require(:portfolio).permit(:title, :subtitle, :body))

    respond_to do |format|
      if @item.save
        format.html { redirect_to portfolios_path, notice: 'Your portfolio item is now live.' }
      else
        format.html { render :new }
      end
    end
  end

end
