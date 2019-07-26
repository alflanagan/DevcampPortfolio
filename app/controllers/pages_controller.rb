# frozen_string_literal: true

# A controller to display various static pages
class PagesController < ApplicationController
  def home
    @posts = Blog.all
    @skills = Skill.all
  end

  def about
    @skills = Skill.all
  end

  def contact; end
end
