# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'

gem 'debase', '~> 0.2.2'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'

# Use puma as the app server
gem 'puma', '~> 4.1'
# Use rails to build the app
gem 'rails', '~> 5.2.3'
# Use SCSS for stylesheets
gem 'sassc-rails', '~> 2.1'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# user authentication
gem 'devise', '~> 4.6'
# use slugs instead of integers to identify posts
gem 'friendly_id', '~> 5.2'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry-byebug'
end

group :development do
  gem 'fastri', '~> 0.3.1'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rcodetools', '~> 0.8.5'
  gem 'rubocop', '~> 0.74.0'
  gem 'rubocop-performance', '~> 1.4'
  gem 'ruby-debug-ide', '~> 0.7'
  gem 'ruby-lint', '~> 2.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'bootstrap', '~> 4.3'

gem 'jquery-rails', '~> 4.3'

gem 'a_flanagan_view_tool', '~> 0.1.2'

# User authentication and authorization
gem 'petergate', '~> 2.0', '>= 2.0.1'

# include font awesome icons
gem 'font-awesome-sass', '~> 5.8'

# pagination for blog posts, etc.
gem 'kaminari', '~> 1.1', '>= 1.1.1'

gem 'jquery-ui-rails', '~> 6.0', '>= 6.0.1'

# support for uploading files
gem 'carrierwave', '~> 1.3', '>= 1.3.1'

# image manipulation
gem 'mini_magick', '~> 4.9', '>= 4.9.3'

# store uploaded files on AWS S3
gem 'carrierwave-aws', '~> 1.3'

# nested forms
gem 'cocoon', '~> 1.2', '>= 1.2.14'

# fancy pop-up fading notifications
gem 'gritter', '~> 1.2'

# in-memory database
gem 'redis', '~> 4.1', '>= 4.1.2'

# fast ruby-based markdown parser
gem 'redcarpet', '~> 3.5'

# standards-based parser
gem 'commonmarker', '~> 0.20.1'

# syntax highlighting for code blocks
gem 'coderay', '~> 1.1', '>= 1.1.2'

# favicon generator for multiple platforms
gem 'rails_real_favicon', '~> 0.0.12'

gem 'webpacker', '~> 4.0', '>= 4.0.7'
