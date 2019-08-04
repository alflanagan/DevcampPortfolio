# frozen_string_literal: true

# A blog post.
class Blog < ApplicationRecord
  enum status: { draft: 0, published: 1 }
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates_presence_of :title, :body, :topic_id

  belongs_to :topic

  has_many :comments, dependent: :destroy

  # special scope for featured blogs, not currently used
  def self.featured
    limit(2)
  end

  # scope for blogs, most recent, admin user
  def self.recent
    order('created_at DESC')
  end

  # scope of blogs for a specific topic, all users
  def self.with_topic(topic_id)
    where(topic_id: topic_id)
  end
end
