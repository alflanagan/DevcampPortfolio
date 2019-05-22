# frozen_string_literal: true

class Portfolio < ApplicationRecord
  include Placeholder
  validates_presence_of :title, :body, :main_image, :thumb_image

  def self.angular
    where(subtitle: 'Angular')
  end

  scope :ruby_on_rails, -> { where(subtitle: 'Ruby on Rails') }

  after_initialize :set_defaults

  def set_defaults
    # self.main_image ||= 'https://via.placeholder.com/600x400.png?text=Portfolio+Image'
    # self.thumb_image ||='https://via.placeholder.com/350x200.png?text=Portfolio+Thumbnail'
    self.main_image ||= Placeholder.image_generate(height: 600, width: 400)
    self.thumb_image ||= Placeholder.image_generate(height: 350, width: 200)
  end

end
