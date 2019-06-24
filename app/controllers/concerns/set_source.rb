# frozen_string_literal: true

# Set session variable :source from URL params
module SetSource
  extend ActiveSupport::Concern

  included do
    before_action :set_source
  end

  def set_source
    session[:source] = params[:q] if params[:q]
  end
end
