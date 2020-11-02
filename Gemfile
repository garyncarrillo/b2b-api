source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.4'

gem 'rails', '6.0.1'

gem 'caxlsx', ' 3.0.2'
gem 'caxlsx_rails', '0.6.2'
gem 'aasm', '5.0.6'
gem 'aws-sdk-s3','1.53.0'
gem 'aws-sdk-rails', '3.0.5'
gem 'active_storage_validations', '0.8.8'
gem 'devise', '4.7.1'
gem 'devise-jwt', '0.6.0'
gem 'devise_invitable', '2.0.1'
gem 'fast_jsonapi', '1.5'
gem 'pg', '1.2.2'
gem 'puma', '4.3.1'
gem 'rack-cors', '1.1.1'
gem 'ransack', '2.3.2'
gem 'pagy', '3.7.2'
gem 'draper', '4.0.1'
gem 'sidekiq', '6.0.4'
gem 'bootsnap', '>= 1.1.0', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'dotenv-rails'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
