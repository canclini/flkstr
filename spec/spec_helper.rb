require 'spork'

Spork.prefork do
 # Loading more in this block will cause your tests to run faster. However,
 # if you change any configuration or code from libraries loaded here, you'll
 # need to restart spork for it take effect.
 ENV["RAILS_ENV"] ||= 'test' 

 require 'simplecov'
 SimpleCov.start 'rails'
 
 require File.expand_path("../../config/application", __FILE__) #preload gems
 #require File.expand_path("../../config/environment", __FILE__)
  
 require 'rspec/rails'
 require 'capybara/rspec' 
 require 'database_cleaner'
 # Requires supporting files with custom matchers and macros, etc,
 # in ./support/ and its subdirectories.
 Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
 
 include MailerMacros
 include AuthMacros
 
 RSpec.configure do |config|
   config.mock_with :rspec
   # If you're not using ActiveRecord, or you'd prefer not to run each of your
   # examples within a transaction, comment the following line or assign false
   # instead of true.
   config.use_transactional_fixtures = true
   config.use_instantiated_fixtures = false
   
   config.before(:suite) do
     DatabaseCleaner.strategy = :transaction
     DatabaseCleaner.clean_with(:truncation)
   end
   
   config.before(:each) do
     reset_email     
    DatabaseCleaner.start
   end
   
   config.after(:each) do
     DatabaseCleaner.clean
   end
 end
end

Spork.each_run do
 # This code will be run each time you run your specs.
 # Flockstreet::Application.reload_routes!
 require 'factory_girl_rails'
require File.expand_path("../../config/environment", __FILE__)
 
  # ActiveSupport::Dependencies.clear
  # ActiveRecord::Base.instantiate_observers
 
end