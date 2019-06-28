# frozen_string_literal: true

# Provides placeholder images for site layout
module Placeholder
  extend ActiveSupport::Concern

  def self.image_generate(height:, width:)
    "https://via.placeholder.com/#{width}x#{height}.png"
  end
end
