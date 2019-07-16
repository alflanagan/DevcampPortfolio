# frozen_string_literal: true

# Custom User to implement default for users who have not logged in.
class GuestUser < User
  attr_accessor :name, :first_name, :last_name, :email, :id
end
