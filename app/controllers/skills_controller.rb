# frozen_string_literal: true

# Controller for skills
class SkillsController < ApplicationController
  access all: [],
         site_admin: :all

  def edit
    site_admin_only do
      @skill = Skill.find(params[:id])
    end
  end

  def index
    @skills = Skill.all
  end

  def update
    @skill = Skill.find(params[:id])
    site_admin_only do
      respond_to do |format|
        if @skill.update(skill_params)
          format.html { redirect_to skills_index_path, notice: 'Update successful!' }
        else
          format.html { redirect_to skills_index_path, notice: 'Failure on update!' }
        end
      end
    end
  end

  private

    def site_admin_only(&_)
      if logged_in? :site_admin
        yield
      else
        render status: :unauthorized
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def skill_params
      params.require(:skill).permit(:title, :percent_used, :badge)
    end

end
