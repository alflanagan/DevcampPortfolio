# frozen_string_literal: true

module ApplicationCable
  # connection to provide applicable user for jobs
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    # "guest" user account specific to ActionCable
    def guest_user
      guest = GuestUser.new
      guest.id = guest.object_id
      guest.name = 'Guest User'
      guest.first_name = 'Guest'
      guest.last_name = 'User'
      guest.email = 'guest@example.com'
      guest
    end

    def connect
      self.current_user = find_verified_user || guest_user
      logger.add_tags 'ActionCable', current_user.email
      logger.add_tags 'ActionCable', current_user.id
    end

    protected

      def find_verified_user
        # don't have access to devise directly, so check env
        verified_user = env['warden'].user
        verified_user
      end
  end
end
