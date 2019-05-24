# frozen_string_literal: true

# Controller for the portfolios model.
class PortfoliosController < ApplicationController
  def index
    @items = Portfolio.all
  end

  def angular
    @items = Portfolio.angular
  end

  def new
    @item = Portfolio.new
    3.times { @item.technologies.build }
  end

  def show
    @item = Portfolio.find(params[:id])
  end

  def destroy
    @item = Portfolio.find(params[:id])
    @item.destroy
    respond_to do |format|
      format.html { redirect_to portfolios_path, notice: "Portfolio '#{@item.title}' was removed." }
    end
  end

  def create
    @item = Portfolio.new(portfolio_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to portfolios_path, notice: 'Your portfolio item is now live.' }
      else
        format.html { render :new }
      end
    end
  end

  def edit
    @item = Portfolio.find(params[:id])
  end

  def update
    @item = Portfolio.find(params[:id])
    respond_to do |format|
      if @item.update(portfolio_params)
        format.html { redirect_to portfolios_path, notice: 'The record successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  private

    def portfolio_params
      params.require(:portfolio).permit(:title,
                                        :subtitle,
                                        :body,
                                        technologies_attributes: [:name])
    end
end
