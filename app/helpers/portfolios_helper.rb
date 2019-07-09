# frozen_string_literal: true

# Helpers for the Portfolios controller
module PortfoliosHelper
  def image_generate(height, width)
    @index = 1 if @index.nil?
    # "https://via.placeholder.com/#{height}x#{width}.png"
    # nicer (default keyword: kitten)
    fred = '"' + @index.to_s + '"'
    @index += 1
    "https://loremflickr.com/#{height}/#{width}?random=#{fred}"
  end

  def portfolio_img(img)
    if img.url
      img.url
    elsif img.mounted_as == :thumb_image
      image_generate '350', '200'
    else
      image_generate '600', '400'
    end
  end
end
