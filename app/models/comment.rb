# frozen_string_literal: true

# A Comment is written by a user about a blog post.
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :blog
end
