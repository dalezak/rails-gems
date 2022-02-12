source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.0"

gem "rails", "~> 7.0.1"

gem "sprockets-rails"

gem "pg", "~> 1.1"

gem "puma", "~> 5.0"

gem "turbo-rails"
gem "stimulus-rails"
gem "jsbundling-rails"
gem "cssbundling-rails"

gem "jbuilder"

gem 'sidekiq'
gem "redis", "~> 4.0"
gem 'redis-rails'
gem 'rails_autoscale_agent'

gem 'devise', '~> 4.8', '>= 4.8.1'
gem 'devise-i18n'

gem "cancancan", "~> 3.3"

gem "omniauth", "~> 2.0"
gem "omniauth-github", "~> 2.0"
gem 'omniauth-rails_csrf_protection', '~> 1.0', '>= 1.0.1'

gem "bootstrap_form", "~> 5.0"
gem "devise-bootstrap5", "~> 0.1.3"

gem "gems"

gem 'store_attribute'

gem "shrine", "~> 3.4"
gem "fastimage", "~> 2.2"
gem "aws-sdk-s3", "~> 1.112"
gem "image_processing", "~> 1.12"

gem "bootsnap", require: false

group :development do
  gem "faker", "~> 2.19"
  gem 'rails-erd'
  gem 'annotate'
  gem 'web-console'
  gem "memory_profiler"
  gem 'derailed_benchmarks'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'brakeman'
  gem "bullet"
  gem 'rubocop'
  gem 'rubocop-rails', require: false
  gem 'active_record_doctor'
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end

group :development, :test do
  gem "debug", platforms: %i[mri mingw x64_mingw]
end

group :production do
  gem 'scout_apm'
end