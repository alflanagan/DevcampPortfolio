# frozen_string_literal: true

class Skill < ApplicationRecord
  include Placeholder
  validates_presence_of :title, :percent_used

  after_initialize :set_defaults

  def set_defaults
    self.badge ||= Placeholder.image_generate(height: 250, width: 250)
  end
end
