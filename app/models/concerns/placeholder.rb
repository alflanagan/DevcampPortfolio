module Placeholder

  extend ActiveSupport::Concern

  def self.image_generate(height:, width:)
    "https://via.placeholder.com/#{height}x#{width}.png"
  end
end
