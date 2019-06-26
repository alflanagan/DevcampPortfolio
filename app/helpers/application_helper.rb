# frozen_string_literal: true

# application-wide helper methods
module ApplicationHelper
  # return a link to 'Logout', or two to 'Register' and 'Login', as appropriate for current user
  def login_helper(style = '')
    if current_user.is_a? GuestUser
      (link_to 'Register', new_user_registration_path, class: style) +
        (link_to 'Login', new_user_session_path, class: style)
    else
      link_to 'Logout', destroy_user_session_path, method: :delete, class: style
    end
  end

  def source_helper(layout_name)
    return unless session[:source]

    greeting = "Thanks for visiting me from #{session[:source]}"
    greeting = "#{greeting} and you are on the #{layout_name} layout"
    content_tag :p, greeting, class: 'source-greeting'
  end

  def copyright_generator
    AFlanaganViewTool::Renderer.copyright('A Lloyd Flanagan', 'All rights reserved')
  end
end
