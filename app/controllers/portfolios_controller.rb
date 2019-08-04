# frozen_string_literal: true

# Controller for the portfolios model.
class PortfoliosController < ApplicationController
  before_action :set_portfolio_item, only: [:edit, :show, :update, :destroy]
  layout 'portfolio'
  access all: [:show, :index],
         user: { except: [:edit, :update, :create, :destroy, :new, :sort] },
         site_admin: :all

  def index
    @portfolio_items = Portfolio.by_position
  end

  def sort
    params[:order].each do |_, value|
      # value is hash with keys :id and :position
      Portfolio.find(value[:id]).update(position: value[:position])
    end
    @portfolio_items = Portfolio.by_position
    render :index
  end

  def new
    @portfolio_item = Portfolio.new
  end

  def show; end

  def destroy
    @portfolio_item.destroy
    respond_to do |format|
      msg = "Portfolio '#{@portfolio_item.title}' was removed."
      format.html { redirect_to portfolios_path, notice: msg }
    end
  end

  def create
    @portfolio_item = Portfolio.new(portfolio_params)

    respond_to do |format|
      if @portfolio_item.save
        format.html { redirect_to portfolios_path, notice: 'Your portfolio item is now live.' }
      else
        format.html { render :new }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @portfolio_item.update(portfolio_params)
        format.html { redirect_to portfolios_path, notice: 'The record successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  private

    def set_portfolio_item
      @portfolio_item = Portfolio.find(params[:id])
    end

    def portfolio_params
      params.require(:portfolio).permit(:title,
                                        :subtitle,
                                        :body,
                                        :main_image,
                                        :thumb_image,
                                        # :_destroy is special value for cocoon
                                        technologies_attributes: [:id, :name, :_destroy])
    end
end
