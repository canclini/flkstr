source 'http://rubygems.org'

gem 'rails', '3.0.7'
gem 'rails3-generators'

gem 'haml'
gem 'compass', '>= 0.10.5'
gem 'simple_form', '>=1.3.0'
gem 'will_paginate', '3.0.pre2'
gem 'acts-as-taggable-on'
gem 'devise', '1.1.3' # 1.3.1 gives a hash error
gem 'geokit'
gem 'cheddargetter'
gem 'twitter'
#gem 'paperclip'
gem 'carrierwave'
gem 'rmagick'
gem 'aws-s3'
gem 'delayed_job', '>=2.1.pre2'
gem 'chameleon'
#gem 'hpricot'
#gem 'tolk'

# To use debugger
# gem 'ruby-debug'

group :test, :development do
  gem 'rspec-rails', ">= 2.6.1"
  gem 'ruby-mysql'
  gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i
  gem 'growl'  
  gem 'guard-livereload'    
  gem 'launchy'
end

group :test do
#  gem 'spork', '~> 0.9.0.rc'
#  gem 'guard-spork'
  gem "factory_girl_rails"
  gem "capybara"
  gem 'guard-rspec'
  gem 'database_cleaner'
end

# postgres gem which makes sure that the encoding is properly done on the heroku platform
gem "pg", :group => :production 
