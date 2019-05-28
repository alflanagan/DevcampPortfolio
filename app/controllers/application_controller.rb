# frozen_string_literal: true

# Base class for all controllers in the application
class ApplicationController < ActionController::Base
  include DeviseWhitelist
  include SetSource
  include CurrentUserConcern
  include DefaultPageContent
end
