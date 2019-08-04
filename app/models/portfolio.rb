# frozen_string_literal: true

class Portfolio < ApplicationRecord
  has_many :technologies, inverse_of: :portfolio
  accepts_nested_attributes_for :technologies,
                                allow_destroy: true,
                                reject_if: ->(attributes) { attributes['name'].blank? }

  validates_presence_of :title, :body

  mount_uploader :thumb_image, PortfolioUploader
  mount_uploader :main_image, PortfolioUploader

  def self.by_position
    order('position ASC')
  end

  scope :ruby_on_rails, -> { where(subtitle: 'Ruby on Rails') }
end
