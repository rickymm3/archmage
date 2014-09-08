source "https://rubygems.org"
ruby "2.1.1"
gem "rails", "4.1.1"
gem 'rails_12factor', group: :production

# Use PostgreSQL as the database for Active Record
gem "pg", :require => "pg"

# Compressor of JavaScript assets
gem "uglifier", ">= 1.3.0"

# Use CoffeeScript for .js.coffee assets and views
gem "coffee-rails", "~> 4.0.0"

# Use jQuery as the JavaScript library
gem "jquery-rails"

# User authentication
gem "devise", "3.2.4"

gem "omniauth-facebook"
gem "kaminari"
gem "ransack"
gem "dynamic_form"

group :test, :development do
  gem "rspec-rails"
  gem "debugger"
  gem "awesome_print"
end

group :development do
  gem "chronic"
  gem "admin_view"
end

group :test do
  gem "factory_girl_rails"
  gem "cucumber-rails", :require => false
  gem "database_cleaner"
  gem "selenium-webdriver"
  gem "capybara"
  gem "shoulda"
  gem "email_spec"
end

group :production, :development do
  gem "thin"
end

gem 'haml-rails'
gem 'better_errors',      group: :development
gem "binding_of_caller"

gem "twitter-bootstrap-rails", :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git', branch:'bootstrap3'
gem "therubyracer"
gem "less-rails"

gem 'will_paginate', '~> 3.0'
gem 'ancestry'
gem 'seed_dump'
gem 'cancancan'

gem 'rails-timeago'

gem 'sass', '~> 3.4.3'