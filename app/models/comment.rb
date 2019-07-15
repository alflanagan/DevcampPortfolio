# frozen_string_literal: true

# A Comment is written by a user about a blog post.
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :blog

  validates :content, presence: true, length: { minimum: 5, maximum: 1000 }
end