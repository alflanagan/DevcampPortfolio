# frozen_string_literal: true

# A job to broadcast comment create/update
class CommentBroadcastJob < ApplicationJob
  queue_as :default

  def perform(comment)
    # create channel for this blog
    ActionCable.server.broadcast "blogs_#{comment.blog.id}_channel", comment: render_comment(comment)
  end

  private

    def render_comment(comment)
      CommentsController.render partial: 'comments/comment', locals: { comment: comment }
    end
end
