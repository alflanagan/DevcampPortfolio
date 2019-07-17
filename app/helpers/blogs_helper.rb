# frozen_string_literal: true

# Helpers for the Blogs controller
module BlogsHelper
  def gravatar_helper(user)
    image_tag "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email)}", width: 60
  end

  # convert string to form that defines a JS template
  def make_js_template(raw_string)
    "`#{raw_string.gsub('`', '\\\\`')}`"
  end
end
