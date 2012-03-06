# -*- encoding : utf-8 -*-
require 'rubygems'
require 'spork'

Spork.prefork do
  # This file is copied to spec/ when you run 'rails generate rspec:install'
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'capybara/rspec'

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.mock_with :rspec
    config.use_transactional_fixtures = true
    config.use_instantiated_fixtures = false
    config.before(:suite) do
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.clean_with(:truncation)
    end
    config.include Factory::Syntax::Methods
    config.include(MailerMacros)
    config.include(AuthMacros)

    config.before(:each) do
      reset_email
      DatabaseCleaner.start

      #Stub out the geo locator
      loc = mock(
        lng: 47.4961324,
        lat: 8.7190118
      )
      Geokit::Geocoders::YahooGeocoder.stub(:geocode).and_return(loc)
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end

    config.treat_symbols_as_metadata_keys_with_true_values = true
    config.filter_run :focus => true
    config.run_all_when_everything_filtered = true
  end
end

Spork.each_run do
  # This code will be run each time you run your specs.
  FactoryGirl.reload

end
