source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.6'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.1.0'
# Use PostgreSQL as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 6.0'
# Use SCSS for stylesheets
gem 'sassc-rails'
# Use Terser as compressor for JavaScript assets
gem 'terser'
gem 'devise', '~> 4.9'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
#gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.11'
# Use Redis adapter to run Action Cable in production
gem 'redis'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1'
#Textacular exposes full text search capabilities from PostgreSQL, extending ActiveRecord with scopes making search easy and fun!
gem 'textacular', '~> 5.0'
#Complete Ruby geocoding solution.http://www.rubygeocoder.com/
gem 'geocoder'

gem 'jquery-rails'
gem 'rubocop-rails'
gem 'gemoji'

gem 'jquery-ui-rails'

gem 'ffaker'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.16.0', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.2.0'
  gem 'listen', '~> 3.8'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests
  gem 'webdrivers'
  gem "factory_bot_rails"
  gem 'pry'
  gem 'pry-byebug'

end
# Figaro Helps to secure API keys: https://github.com/laserlemon/figaro
gem "figaro"
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:windows, :jruby]
#Rails view helper for grabbing Gravatar images. The goal here is to be configurable and have those configuration points documented! https://github.com/mdeering/gravatar_image_tag
gem 'gravatar_image_tag'
