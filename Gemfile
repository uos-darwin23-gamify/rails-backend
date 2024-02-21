# frozen_string_literal: true

source "https://rubygems.org"

ruby "3.1.2"

gem "whenever"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.2"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

gem "mongoid", "~> 8.1"
# gem "mongoid_rails_migrations"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mswin mswin64 mingw x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin Ajax possible
gem "rack-cors"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri mswin mswin64 mingw x64_mingw]
  gem "letter_opener"
  gem "rspec-rails", "~> 6.1"
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
  gem "error_highlight", ">= 0.4.0", platforms: [:ruby]
  gem "letter_opener"
end

gem "hamlit-rails", "~> 0.2.3"

gem "html2haml", "~> 2.3"

gem "activerecord-session_store"
gem "devise"
gem "devise-jwt"
gem "devise-jwt-cookie"
gem "dry-container", "0.7.2"
gem "faker"
gem "jsonapi-serializer"
gem "rubocop"
gem "rubocop-capybara"
gem "rubocop-factory_bot"
gem "rubocop-rails"
gem "rubocop-rspec"
gem "sentry-rails"
gem "sentry-ruby"
