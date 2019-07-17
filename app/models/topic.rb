# frozen_string_literal: true

class Topic < ApplicationRecord
  validates_presence_of :title

  has_many :blogs

  # scope: topics with at least one published blog entry
  scope :published, -> { where(id: Blog.where(status: :published).select(:topic_id)) }
end
