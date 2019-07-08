# frozen_string_literal: true

class Portfolio < ApplicationRecord
  has_many :technologies
  accepts_nested_attributes_for :technologies,
                                reject_if: ->(attributes) { attributes['name'].blank? }
  include Placeholder
  validates_presence_of :title, :body, :main_image, :thumb_image

  mount_uploader :thumb_image, PortfolioUploader
  mount_uploader :main_image, PortfolioUploader

  def self.angular
    where(subtitle: 'Angular')
  end

  def self.by_position
    order('position ASC')
  end

  scope :ruby_on_rails, -> { where(subtitle: 'Ruby on Rails') }

end
