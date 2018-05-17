# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'

# simplecov and codacy coverage
require 'simplecov'
require 'codacy-coverage'
SimpleCov.start 'rails' do
  add_filter '/app/channels'
end
Codacy::Reporter.start

require_relative '../config/environment'
require 'rails/test_help'

module ActiveSupport
  class TestCase
    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end
