source 'https://rubygems.org'

gem 'rake'
gem 'hanami',       '~> 1.2'
gem 'hanami-model', '~> 1.2'

# Postgresql
gem 'pg'

group :development do
  # Code reloading
  # See: http://hanamirb.org/guides/projects/code-reloading
  gem 'shotgun', platforms: :ruby
  gem 'hanami-webconsole'
end

group :test, :development do
  gem 'dotenv', '~> 2.0'
  gem 'rubocop', require: false
  gem 'overcommit'
  gem 'fasterer'
  gem 'bundler-audit'
end

group :test do
  gem 'rspec'
  gem 'simplecov', require: false
  # gem 'capybara'
end

group :production do
  gem 'puma'
end
