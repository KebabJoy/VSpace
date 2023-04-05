source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.5'

gem 'rails', '~> 6.1.5'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'blueprinter'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'faraday'
gem 'faraday_middleware'
gem 'dry-initializer'
gem 'dry-monads', '~> 1.3'
gem 'rails-i18n', '~> 7.0.0'
gem 'searchlight'
gem 'rack-cors'
gem 'connection_pool'
gem 'hiredis'
gem 'redis', '~> 4.6.0', require: ['redis', 'redis/connection/hiredis']
gem 'redis-store', '~> 1.9.1'
gem 'redis-rails'
gem 'will_paginate' # Tell on pagination: offsets, grep prev page id etc..
gem 'oj'
gem 'sunspot_rails', '2.6.0'
gem 'sunspot_solr', '2.6.0' # optional pre-packaged Solr distribution for use in development

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry'
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  gem 'spring'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver', '>= 4.0.0.rc1'
  gem 'webdrivers'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
