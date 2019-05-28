# frozen_string_literal: true

# set default values for page content variables
module DefaultPageContent
  extend ActiveSupport::Concern

  included do
    before_action :set_page_defaults
  end

  def set_page_defaults
    @page_title = 'DevCamp Portfolio | My Portfolio Website'
    @seo_keywords = 'Adrian Lloyd Flanagan portfolio'
  end
end
