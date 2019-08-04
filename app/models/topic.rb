# frozen_string_literal: true

class Topic < ApplicationRecord
  validates_presence_of :title

  has_many :blogs

  # A custom scope
  def self.with_blogs
    includes(:blogs).where.not(blogs: { id: nil }).order('topics.title')
  end

  # scope: topics with at least one published blog entry
  scope :published, -> { where(id: Blog.where(status: :published).select(:topic_id)) }
end
