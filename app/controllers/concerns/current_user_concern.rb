# frozen_string_literal: true

# Add a "guest user" user for users who haven't logged in.
module CurrentUserConcern
  extend ActiveSupport::Concern

  def current_user
    super || guest_user
  end

  def guest_user
    OpenStruct.new(name: 'Guest User',
                   first_name: 'Guest',
                   last_name: 'User',
                   email: 'guest.user@example.com')
  end
end
