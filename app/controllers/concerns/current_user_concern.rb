# frozen_string_literal: true

# Add a "guest user" user for users who haven't logged in.
module CurrentUserConcern
  extend ActiveSupport::Concern

  def current_user
    super || guest_user
  end

  def guest_user
    guest = GuestUser.new
    guest.name = 'Guest User'
    guest.first_name = 'Guest'
    guest.last_name = 'User'
    guest.email = 'guest_user@example.com'
    guest
  end
end
