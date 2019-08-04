# frozen_string_literal: true

# Helpers for the Blogs controller
module BlogsHelper
  def gravatar_helper(user)
    image_tag "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email)}", width: 60
  end

  # Extend HTML renderer to use CodeRay. Not using recommended class names because a
  # class should be a noun, dammit.
  class HTMLWithCoderay < Redcarpet::Render::Safe
    def block_code(code, language)
      CodeRay.scan(code, language).div
    end
  end

  # set up filter to convert markdown to HTML
  def markdown(text)
    htmlcoderay = HTMLWithCoderay.new(filter_html: true,
                                      hard_wrap: true)
    options = {
      fenced_code_blocks: true,
      no_intra_emphasis: true,
      autolink: true,
      lax_html_blocks: true,
      tables: true,
      strikethrough: true,
      superscript: true,
      underline: true,
      highlight: true,
      footnotes: true,
      with_toc_data: true
    }

    markdown_to_html = Redcarpet::Markdown.new(htmlcoderay, options)
    begin
      markdown_to_html.render(text).html_safe
    rescue ArgumentError => e
      "<h1>Error in Markdown: #{e.message}</h1><p>#{@blog.body}</p>".html_safe
    end
  end

  def blog_status_color(blog)
    'color: red;' if blog.status == 'draft'
  end

  # convert string to form that defines a JS template
  def make_js_template(raw_string)
    "`#{raw_string.gsub('`', '\\\\`')}`"
  end
end
