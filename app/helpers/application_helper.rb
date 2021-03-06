# frozen_string_literal: true

# application-wide helper methods
module ApplicationHelper
  def nav_items
    items = [{ title: 'Home', url: root_path },
             { title: 'About Me', url: about_me_path },
             { title: 'Contact', url: contact_path },
             { title: 'Blog', url: blogs_path },
             { title: 'Portfolio', url: portfolios_path }]
    items << { title: 'Skills', url: skills_index_path } if logged_in? :site_admin
    items
  end

  # return a link to 'Logout', or two to 'Register' and 'Login', as appropriate for current user
  def login_helper(style = '')
    if current_user.is_a? GuestUser
      _span(link_to('Register', new_user_registration_path, class: style)) +
        _span(link_to('Login', new_user_session_path, class: style))
    else
      _span(link_to('Logout', destroy_user_session_path, method: :delete, class: style))
    end
  end

  def copyright_generator
    AFlanaganViewTool::Renderer.copyright('A Lloyd Flanagan', 'All rights reserved')
  end

  def nav_helper(style = 'nav-link', tag_type = 'span')
    result = +'' # thawed
    nav_items.each do |item|
      link_text = link_to item[:title], item[:url], class: "#{style} #{active? item[:url]}"
      result << "<#{tag_type}>#{link_text}</#{tag_type}>\n"
    end
    result.html_safe
  end

  # display a gritter message to the user
  # if message is not provided, displays flash notice if one is found
  def alerts(message = nil)
    message = flash[:alert] || flash[:error] || flash[:notice] if message.nil?
    js add_gritter(message, title: 'A Lloyd Flanagan Website') if message
  end

  private

    def _span(html_str)
      "<span>#{html_str}</span>".html_safe
    end

    def active?(path)
      'active' if current_page? path
    end
end
