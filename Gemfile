source 'http://rubygems.org'

gem 'rails', '3.1.0'
gem 'rails3-generators'

group :assets do
  gem 'sass-rails', "~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'jquery-rails'

gem 'haml'
gem "compass", "~> 0.12.alpha.0"
#gem 'compass', '>= 0.11.5', :require => false
gem 'simple_form', '>=1.3.0'
gem 'will_paginate', "= 3.0.pre4"
gem 'acts-as-taggable-on', :git => "git://github.com/mbleigh/acts-as-taggable-on.git"

gem 'geokit'
gem 'cheddargetter'
gem 'twitter'
gem 'carrierwave'
gem 'rmagick'
gem 'aws-s3'
gem 'delayed_job', '>=2.1.pre2'
gem 'chameleon' # geckoboard widget builder
gem 'thin' # webserver, specially used for heroku, also executeble with foreman

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test, :development do
	gem 'foreman'
  gem 'rspec-rails', ">= 2.6.1"
 	gem 'mysql2', ">=0.3"
  gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i
  gem 'growl'  
  gem 'guard-livereload'    
  gem 'launchy'
	gem 'fuubar'
end

group :test do
  gem 'spork', '~> 0.9.0.rc'
  gem 'guard-spork'
  gem 'factory_girl_rails', :require => false
  gem "capybara"
  gem 'guard-rspec'
  gem 'database_cleaner'
  gem 'turn', :require => false
  gem 'simplecov', '>= 0.4.0', :require => false
end

group :production do
	gem 'therubyracer-heroku' # or use heroku stack cedar
	# postgres gem which makes sure that the encoding is properly done on the heroku platform
	gem "pg", :group => :production 
end
