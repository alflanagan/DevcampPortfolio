# frozen_string_literal: true

# A blog post.
class Blog < ApplicationRecord
  enum status: { draft: 0, published: 1 }
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates_presence_of :title, :body

  belongs_to :topic

  has_many :comments, dependent: :destroy

  def self.special_blogs
    all
  end

  def self.featured
    limit(2)
  end

  def self.with_topic(topic_id)
    where(topic_id: topic_id)
  end
end
