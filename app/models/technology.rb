# frozen_string_literal: true

# A "technology" that can be used in building a portfolio item
class Technology < ApplicationRecord
  belongs_to :portfolio
end
