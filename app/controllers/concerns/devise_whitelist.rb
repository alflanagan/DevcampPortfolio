# frozen_string_literal: true

# whitelist for parameters sent to devise
module DeviseWhitelist
  extend ActiveSupport::Concern

  included do
    before_action :configure_permitted, if: :devise_controller?
  end

  def configure_permitted
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
