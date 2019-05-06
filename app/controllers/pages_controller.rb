# frozen_string_literal: true

# A controller to display various static pages
class PagesController < ApplicationController
  def home
    @posts = Blog.all
  end

  def about; end

  def contact; end
end
