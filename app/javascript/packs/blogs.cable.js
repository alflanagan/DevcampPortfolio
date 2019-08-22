/* global $, App */

export function actionCableCommentSubmit () {
  const comments = $('#comments')
  if (comments.length > 0) {
    App.global_chat = App.cable.subscriptions.create(
      {
        channel: 'BlogsChannel',
        blog_id: comments.data('blog-id')
      },
      {
        connected: () => {},
        disconnected: () => {},
        received: data => comments.append(data['comment']),
        send_comment: function (comment, blogId) {
          return this.perform('send_comment',
            {
              comment: comment,
              blog_id: blogId
            }
          )
        }
      }
    )
  }
  return $('#new_comment').submit(function (e) {
    const $this = $(this)
    const textarea = $this.find('#comment_content');
    if ($.trim(textarea.val()).length > 1) {
      App.global_chat.send_comment(textarea.val(), comments.data('blog-id'))
      textarea.val('')
    }
    e.preventDefault()
    return false
  })
}
