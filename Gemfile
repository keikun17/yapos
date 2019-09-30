source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.4'

gem 'client_side_validations'
gem 'rails', '~> 6.0.0'
#
# Use Puma as the app server
gem 'puma', '~> 3.11'

gem 'autoprefixer-rails'
gem 'coffee-rails'

# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'

gem 'haml-rails', '~> 2.0'
#
# Use SCSS for stylesheets
# gem 'sass-rails', '~> 5'
gem 'sass-rails', '~> 6.0.0'

gem 'jquery-rails', '~> 4.3'
# gem 'jquery-ui-sass-rails'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

gem 'bootstrap-sass', '~> 3.3.3'
# gem 'web-console', '~> 4.0.1'
gem 'responders'

gem 'draper', '~> 3.1.0'

gem 'active_model_serializers', '0.9.0'

# attr_protected and attr_accessible has been extracted to a gem
# gem 'protected_attributes'
# TODO : use Strong attributes
# gem 'protected_attributes_continued'

gem 'devise', '~> 4.7.1'
gem 'carrierwave'

# Preferred Elasticsearch gem/mapper
gem 'elasticsearch-model', '0.1.6'
gem 'elasticsearch-rails', '~> 0.1.6'

gem 'json', '~> 1.8.2'

group :development do
  # gem 'quiet_assets'
  gem 'annotate', '~> 3.0.0'

  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'capistrano', '~> 3.4.0', require: false
  gem 'bullet'
  gem 'yard'

  gem 'gem-ctags'
end

gem 'thin'
gem 'will_paginate', '~> 3.1.8'
gem 'acts_as_commentable_with_threading'

gem 'mysql2'

gem 'counter_culture'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'libv8', '~> 3.16.14.13'
# gem 'therubyracer', '0.12.2'
gem 'uglifier', '>= 1.3.0'

gem 'groupdate'
gem 'chartkick'
gem 'active_median', '~> 0.2.3'


group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rubocop-rspec', require: false
  # gem 'rspec-rails', '~> 3.8.2'
  gem 'pry-nav'
  gem 'haml_lint', '~> 0.33.0', require: false
  gem 'rubocop', require: false
  # gem 'rails_best_practices', require: false
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'

  # gem 'selenium-webdriver', '2.44.0' # because 2.45.0 is SUPER SLOW
  # gem 'factory_bot_rails'
  # gem 'database_cleaner'
  # gem 'spring-commands-rspec'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
