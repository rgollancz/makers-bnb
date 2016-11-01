
ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', 'app/app.rb')

require 'dm-rspec'
require 'capybara'
require 'capybara/rspec'
require 'rspec'
require 'dm-rspec'
require 'web_helpers'
Capybara.app = Makersbnb

RSpec.configure do |config|
  config.include Capybara::DSL
  config.include DataMapper::Matchers

  config.expect_with :rspec do |expectations|

    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

end
